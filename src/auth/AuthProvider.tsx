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
import { supabase } from '../lib/supabase';

export type UserRole =
  | 'admin'
  | 'operations'
  | 'analyst'
  | 'viewer'
  | 'guest';

interface AuthContextValue {
  user: User | null;
  role: UserRole;
  isGuest: boolean;
  canManageOrders: boolean;
  canViewReports: boolean;
  signOut: () => Promise<void>;
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
  const [isGuest, setIsGuest] = useState(
    () => sessionStorage.getItem('marketops-guest') === 'true'
  );
  const [isLoading, setIsLoading] = useState(true);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState('');

  const loadProfile = async (currentSession: Session) => {
    const { data, error } = await supabase
      .from('user_profiles')
      .select('role')
      .eq('id', currentSession.user.id)
      .single();

    if (error) {
      console.error('Could not load user profile:', error);
      setRole('viewer');
      return;
    }

    setRole((data?.role as UserRole) || 'viewer');
  };

  useEffect(() => {
    let active = true;

    const initialize = async () => {
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
    setIsSubmitting(true);

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

  const continueAsGuest = () => {
    sessionStorage.setItem('marketops-guest', 'true');
    setRole('guest');
    setIsGuest(true);
    setErrorMessage('');
  };

  const signOut = async () => {
    sessionStorage.removeItem('marketops-guest');
    setIsGuest(false);
    setRole('guest');

    if (session) {
      await supabase.auth.signOut();
    }
  };

  const contextValue = useMemo<AuthContextValue>(
    () => ({
      user: session?.user || null,
      role,
      isGuest,
      canManageOrders:
        !isGuest && (role === 'admin' || role === 'operations'),
      canViewReports:
        !isGuest &&
        ['admin', 'operations', 'analyst', 'viewer'].includes(role),
      signOut,
    }),
    [session, role, isGuest]
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
              Sign in to access the operations workspace or continue with
              read-only demonstration access.
            </p>
          </div>

          <form onSubmit={handleLogin} className="space-y-4">
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
                Password
              </label>

              <input
                id="login-password"
                type="password"
                value={password}
                onChange={(event) => setPassword(event.target.value)}
                required
                autoComplete="current-password"
                className="w-full rounded-xl border border-slate-600 bg-slate-800 px-4 py-3 text-sm text-white outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-500/20"
              />
            </div>

            {errorMessage && (
              <p
                role="alert"
                className="rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-300"
              >
                {errorMessage}
              </p>
            )}

            <button
              type="submit"
              disabled={isSubmitting}
              className="w-full rounded-xl bg-blue-600 px-4 py-3 text-sm font-bold text-white transition hover:bg-blue-500 disabled:cursor-not-allowed disabled:opacity-60"
            >
              {isSubmitting ? 'Signing in...' : 'Sign in'}
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
            Continue as Guest
          </button>

          <p className="mt-4 text-center text-xs leading-5 text-slate-500">
            Guest access uses fictional data and does not allow operational
            changes.
          </p>
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