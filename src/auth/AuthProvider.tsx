import {
  createContext,
  type FormEvent,
  type ReactNode,
  useContext,
  useEffect,
  useMemo,
  useState,
} from 'react';
import type { Session, User } from '@supabase/supabase-js';
import { supabase, supabaseConfigured } from '../lib/supabase';

export type UserRole =
  | 'admin'
  | 'operations'
  | 'analyst'
  | 'viewer'
  | 'guest';
export type ApprovalStatus = 'pending' | 'approved' | 'rejected';

interface AuthContextValue {
  user: User | null;
  role: UserRole;
  approvalStatus: ApprovalStatus;
  isGuest: boolean;
  canManageOrders: boolean;
  canViewReports: boolean;
  signOut: () => Promise<void>;
  refreshProfile: () => Promise<void>;
}

const AuthContext = createContext<AuthContextValue | null>(null);

export function useAuth() {
  const context = useContext(AuthContext);

  if (!context) {
    throw new Error('useAuth must be used inside AuthProvider.');
  }

  return context;
}

interface AuthProviderProps {
  children: ReactNode;
}

export function AuthProvider({ children }: AuthProviderProps) {
  const [session, setSession] = useState<Session | null>(null);
  const [role, setRole] = useState<UserRole>('guest');
  const [approvalStatus, setApprovalStatus] = useState<ApprovalStatus>('pending');
  const [isGuest, setIsGuest] = useState(
    () => sessionStorage.getItem('marketops-guest') === 'true'
  );
  const [isLoading, setIsLoading] = useState(true);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [authMode, setAuthMode] = useState<'login' | 'signup'>('login');
  const [errorMessage, setErrorMessage] = useState('');
  const [successMessage, setSuccessMessage] = useState('');

  const loadProfile = async (currentSession: Session) => {
    if (!supabase) return;
    const { data, error } = await supabase
      .from('user_profiles')
      .select('role, approval_status')
      .eq('id', currentSession.user.id)
      .single();

    if (error) {
      console.error('Could not load user profile:', error);
      setRole('viewer');
      setApprovalStatus('pending');
      return;
    }

    setRole((data?.role as UserRole) || 'viewer');
    setApprovalStatus((data?.approval_status as ApprovalStatus) || 'pending');
  };

  const refreshProfile = async () => {
    if (session) await loadProfile(session);
  };

  useEffect(() => {
    let active = true;

    const initialize = async () => {
      if (!supabase) {
        if (active) setIsLoading(false);
        return;
      }
      const { data } = await supabase.auth.getSession();

      if (!active) return;

      setSession(data.session);

      if (data.session) {
        setIsGuest(false);
        sessionStorage.removeItem('marketops-guest');
        await loadProfile(data.session);
      }

      if (active) setIsLoading(false);
    };

    void initialize();

    if (!supabase) return () => { active = false; };

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((_event, nextSession) => {
      setSession(nextSession);

      if (nextSession) {
        setIsGuest(false);
        sessionStorage.removeItem('marketops-guest');
        void loadProfile(nextSession);
      } else {
        setRole('guest');
        setApprovalStatus('pending');
      }
    });

    return () => {
      active = false;
      subscription.unsubscribe();
    };
  }, []);

 const handleLogin = async (event: FormEvent) => {
    event.preventDefault();
    setErrorMessage('');
    setSuccessMessage('');
    setIsSubmitting(true);

    if (!supabase) {
      setErrorMessage('Authentication is not configured. Continue with demonstration access.');
      setIsSubmitting(false);
      return;
    }

    const { error } = await supabase.auth.signInWithPassword({
      email: email.trim(),
      password,
    });

    if (error) {
      console.error('Supabase login error:', error);
      setErrorMessage(error.message);
      setIsSubmitting(false);
      return;
    }

    setPassword('');
    setIsSubmitting(false);
  };

  const handleSignup = async (event: FormEvent) => {
    event.preventDefault();
    setErrorMessage('');
    setSuccessMessage('');

    if (!supabase) {
      setErrorMessage('O cadastro não está configurado neste ambiente. Verifique as variáveis do Supabase.');
      return;
    }
    if (password.length < 6) {
      setErrorMessage('A senha precisa ter pelo menos 6 caracteres.');
      return;
    }
    if (password !== confirmPassword) {
      setErrorMessage('As senhas não coincidem.');
      return;
    }

    setIsSubmitting(true);
    const { data, error } = await supabase.auth.signUp({
      email: email.trim(),
      password,
      options: { emailRedirectTo: window.location.origin },
    });

    if (error) {
      console.error('Supabase signup error:', error);
      setErrorMessage(error.message);
      setIsSubmitting(false);
      return;
    }

    setPassword('');
    setConfirmPassword('');
    setIsSubmitting(false);
    if (!data.session) {
      setAuthMode('login');
      setSuccessMessage('Cadastro realizado. Abra o e-mail de confirmação enviado pelo Supabase e depois entre no MarketOps.');
    }
  };

  const changeAuthMode = (mode: 'login' | 'signup') => {
    setAuthMode(mode);
    setPassword('');
    setConfirmPassword('');
    setErrorMessage('');
    setSuccessMessage('');
  };

  const continueAsGuest = () => {
    sessionStorage.setItem('marketops-guest', 'true');
    setRole('guest');
    setApprovalStatus('pending');
    setIsGuest(true);
    setErrorMessage('');
  };

  const signOut = async () => {
    sessionStorage.removeItem('marketops-guest');
    setIsGuest(false);
    setRole('guest');

    if (session && supabase) {
      await supabase.auth.signOut();
    }
  };

  const contextValue = useMemo<AuthContextValue>(
    () => ({
      user: session?.user || null,
      role,
      approvalStatus,
      isGuest,
      canManageOrders:
        !isGuest && approvalStatus === 'approved' && (role === 'admin' || role === 'operations'),
      canViewReports:
        !isGuest && approvalStatus === 'approved' &&
        ['admin', 'operations', 'analyst', 'viewer'].includes(role),
      signOut,
      refreshProfile,
    }),
    [session, role, approvalStatus, isGuest]
  );

  if (isLoading) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-slate-950 text-slate-200">
        <div className="text-sm font-semibold">Loading MarketOps...</div>
      </div>
    );
  }

  if (!session && !isGuest) {
    return (
      <main className="flex min-h-screen items-center justify-center bg-slate-950 px-4">
        <section className="w-full max-w-md rounded-3xl border border-slate-700 bg-slate-900 p-8 shadow-2xl">
          <div className="mb-8">
            <div className="mb-4 flex h-12 w-12 items-center justify-center rounded-2xl bg-blue-600 text-lg font-black text-white">
              M
            </div>

            <h1 className="text-2xl font-bold text-white">
              MarketOps Control Tower
            </h1>

            <p className="mt-2 text-sm leading-6 text-slate-400">
              {authMode === 'login'
                ? 'Entre para acessar o ambiente operacional ou continue como visitante.'
                : 'Crie sua conta usando um e-mail válido e uma senha segura.'}
            </p>
          </div>

          <div className="mb-5 grid grid-cols-2 rounded-xl border border-slate-700 bg-slate-950/40 p-1">
            <button type="button" onClick={() => changeAuthMode('login')} className={`rounded-lg px-3 py-2 text-sm font-bold transition ${authMode === 'login' ? 'bg-blue-600 text-white' : 'text-slate-400 hover:text-white'}`}>
              Entrar
            </button>
            <button type="button" onClick={() => changeAuthMode('signup')} className={`rounded-lg px-3 py-2 text-sm font-bold transition ${authMode === 'signup' ? 'bg-blue-600 text-white' : 'text-slate-400 hover:text-white'}`}>
              Criar conta
            </button>
          </div>

          <form onSubmit={authMode === 'login' ? handleLogin : handleSignup} className="space-y-4">
            {!supabaseConfigured && (
              <p className="rounded-xl border border-amber-500/30 bg-amber-500/10 px-4 py-3 text-sm text-amber-200">
                Authentication is not configured locally. Use demonstration access below.
              </p>
            )}
            <div>
              <label
                htmlFor="login-email"
                className="mb-1.5 block text-xs font-bold uppercase tracking-wide text-slate-300"
              >
                Email
              </label>

              <input
                id="login-email"
                type="email"
                value={email}
                onChange={(event) => setEmail(event.target.value)}
                required
                autoComplete="email"
                className="w-full rounded-xl border border-slate-600 bg-slate-800 px-4 py-3 text-sm text-white outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-500/20"
              />
            </div>

            <div>
              <label
                htmlFor="login-password"
                className="mb-1.5 block text-xs font-bold uppercase tracking-wide text-slate-300"
              >
                Senha
              </label>

              <input
                id="login-password"
                type="password"
                value={password}
                onChange={(event) => setPassword(event.target.value)}
                required
                autoComplete={authMode === 'login' ? 'current-password' : 'new-password'}
                className="w-full rounded-xl border border-slate-600 bg-slate-800 px-4 py-3 text-sm text-white outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-500/20"
              />
            </div>

            {authMode === 'signup' && (
              <div>
                <label htmlFor="confirm-password" className="mb-1.5 block text-xs font-bold uppercase tracking-wide text-slate-300">
                  Confirmar senha
                </label>
                <input
                  id="confirm-password"
                  type="password"
                  value={confirmPassword}
                  onChange={(event) => setConfirmPassword(event.target.value)}
                  required
                  minLength={6}
                  autoComplete="new-password"
                  className="w-full rounded-xl border border-slate-600 bg-slate-800 px-4 py-3 text-sm text-white outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-500/20"
                />
              </div>
            )}

            {errorMessage && (
              <p
                role="alert"
                className="rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-300"
              >
                {errorMessage}
              </p>
            )}

            {successMessage && (
              <p role="status" className="rounded-xl border border-emerald-500/30 bg-emerald-500/10 px-4 py-3 text-sm text-emerald-200">
                {successMessage}
              </p>
            )}

            <button
              type="submit"
              disabled={isSubmitting}
              className="w-full rounded-xl bg-blue-600 px-4 py-3 text-sm font-bold text-white transition hover:bg-blue-500 disabled:cursor-not-allowed disabled:opacity-60"
            >
              {isSubmitting
                ? (authMode === 'login' ? 'Entrando...' : 'Criando conta...')
                : (authMode === 'login' ? 'Entrar' : 'Cadastrar e-mail e senha')}
            </button>
          </form>

          <div className="my-6 flex items-center gap-3">
            <div className="h-px flex-1 bg-slate-700" />
            <span className="text-xs font-semibold uppercase text-slate-500">
              or
            </span>
            <div className="h-px flex-1 bg-slate-700" />
          </div>

          <button
            type="button"
            onClick={continueAsGuest}
            className="w-full rounded-xl border border-slate-600 bg-slate-800 px-4 py-3 text-sm font-bold text-slate-100 transition hover:border-slate-500 hover:bg-slate-700"
          >
            Continuar como visitante
          </button>

          <p className="mt-4 text-center text-xs leading-5 text-slate-500">
            O acesso de visitante usa dados fictícios e não permite alterações operacionais.
          </p>
        </section>
      </main>
    );
  }

  if (session && approvalStatus !== 'approved') {
    const rejected = approvalStatus === 'rejected';
    return (
      <main className="flex min-h-screen items-center justify-center bg-slate-950 px-4">
        <section className="w-full max-w-md rounded-3xl border border-slate-700 bg-slate-900 p-8 text-center shadow-2xl">
          <div className={`mx-auto mb-5 flex h-14 w-14 items-center justify-center rounded-2xl text-2xl ${rejected ? 'bg-rose-500/20 text-rose-300' : 'bg-amber-500/20 text-amber-300'}`}>
            {rejected ? '×' : '…'}
          </div>
          <h1 className="text-xl font-bold text-white">{rejected ? 'Acesso não aprovado' : 'Cadastro aguardando aprovação'}</h1>
          <p className="mt-3 text-sm leading-6 text-slate-400">
            {rejected
              ? 'O administrador não liberou este cadastro. Entre em contato com a equipe responsável pelo MarketOps.'
              : 'Seu e-mail foi confirmado e o cadastro está correto. Um administrador precisa escolher sua função e aprovar seu acesso.'}
          </p>
          <p className="mt-3 rounded-xl border border-slate-700 bg-slate-800 px-4 py-3 text-sm font-semibold text-slate-200">{session.user.email}</p>
          <div className="mt-6 grid grid-cols-2 gap-3">
            <button type="button" onClick={() => void refreshProfile()} className="rounded-xl bg-blue-600 px-4 py-3 text-sm font-bold text-white hover:bg-blue-500">Verificar aprovação</button>
            <button type="button" onClick={() => void signOut()} className="rounded-xl border border-slate-600 bg-slate-800 px-4 py-3 text-sm font-bold text-slate-200 hover:bg-slate-700">Sair</button>
          </div>
        </section>
      </main>
    );
  }

  return (
    <AuthContext.Provider value={contextValue}>
      {children}
    </AuthContext.Provider>
  );
}
