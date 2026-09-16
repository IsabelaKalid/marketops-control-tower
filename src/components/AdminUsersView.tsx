import React, { useCallback, useEffect, useState } from 'react';
import { Check, RefreshCw, ShieldCheck, UserCheck, UserX } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { useAuth, type ApprovalStatus, type UserRole } from '../auth/AuthProvider';

interface UserProfile {
  id: string;
  email: string;
  role: Exclude<UserRole, 'guest'>;
  approval_status: ApprovalStatus;
  created_at: string;
  approved_at?: string | null;
}

const roleLabels: Record<Exclude<UserRole, 'guest'>, string> = {
  admin: 'Administrador',
  operations: 'Operações',
  analyst: 'Analista',
  viewer: 'Visualização',
};

export const AdminUsersView: React.FC = () => {
  const { user } = useAuth();
  const [profiles, setProfiles] = useState<UserProfile[]>([]);
  const [draftRoles, setDraftRoles] = useState<Record<string, UserProfile['role']>>({});
  const [loading, setLoading] = useState(true);
  const [savingId, setSavingId] = useState<string | null>(null);
  const [feedback, setFeedback] = useState('');

  const loadProfiles = useCallback(async () => {
    if (!supabase) return;
    setLoading(true);
    setFeedback('');
    const { data, error } = await supabase
      .from('user_profiles')
      .select('id,email,role,approval_status,created_at,approved_at')
      .order('created_at', { ascending: false });
    if (error) setFeedback(`Não foi possível carregar os usuários: ${error.message}`);
    else {
      const list = (data || []) as UserProfile[];
      setProfiles(list);
      setDraftRoles(Object.fromEntries(list.map(profile => [profile.id, profile.role])));
    }
    setLoading(false);
  }, []);

  useEffect(() => { void loadProfiles(); }, [loadProfiles]);

  const updateAccess = async (profile: UserProfile, status: ApprovalStatus) => {
    if (!supabase || profile.id === user?.id) return;
    setSavingId(profile.id);
    setFeedback('');
    const { error } = await supabase.from('user_profiles').update({
      role: draftRoles[profile.id] || 'viewer',
      approval_status: status,
      approved_at: status === 'approved' ? new Date().toISOString() : null,
      approved_by: status === 'approved' ? user?.id : null,
      updated_at: new Date().toISOString(),
    }).eq('id', profile.id);
    if (error) setFeedback(`Não foi possível atualizar ${profile.email}: ${error.message}`);
    else {
      setFeedback(status === 'approved' ? `${profile.email} foi aprovado.` : `${profile.email} foi marcado como não aprovado.`);
      await loadProfiles();
    }
    setSavingId(null);
  };

  return <div className="space-y-5">
    <div className="flex flex-wrap items-start justify-between gap-3">
      <div>
        <h1 className="flex items-center gap-2 text-2xl font-bold text-slate-900"><ShieldCheck className="h-6 w-6 text-blue-600"/> Administração de acessos</h1>
        <p className="mt-1 text-sm text-slate-500">Aprove cadastros confirmados e defina o nível de acesso de cada pessoa.</p>
      </div>
      <button onClick={() => void loadProfiles()} disabled={loading} className="inline-flex items-center gap-2 rounded-xl border border-slate-300 bg-white px-4 py-2 text-sm font-bold text-slate-700 hover:bg-slate-50 disabled:opacity-50">
        <RefreshCw className={`h-4 w-4 ${loading ? 'animate-spin' : ''}`}/> Atualizar
      </button>
    </div>

    {feedback && <div className="rounded-xl border border-blue-200 bg-blue-50 px-4 py-3 text-sm text-blue-900">{feedback}</div>}

    <div className="overflow-hidden rounded-2xl border border-slate-200 bg-white shadow-sm">
      <div className="overflow-x-auto">
        <table className="w-full min-w-[850px] text-left text-sm">
          <thead className="bg-slate-100 text-xs uppercase text-slate-600"><tr><th className="px-4 py-3">Usuário</th><th className="px-4 py-3">Situação</th><th className="px-4 py-3">Função</th><th className="px-4 py-3">Cadastro</th><th className="px-4 py-3 text-right">Ações</th></tr></thead>
          <tbody className="divide-y divide-slate-100">
            {profiles.map(profile => {
              const self = profile.id === user?.id;
              return <tr key={profile.id} className="hover:bg-slate-50/70">
                <td className="px-4 py-4"><div className="font-semibold text-slate-900">{profile.email}</div>{self && <span className="text-[10px] font-bold text-blue-600">SUA CONTA</span>}</td>
                <td className="px-4 py-4"><StatusBadge status={profile.approval_status}/></td>
                <td className="px-4 py-4"><select disabled={self || savingId === profile.id} value={draftRoles[profile.id] || profile.role} onChange={event => setDraftRoles(current => ({ ...current, [profile.id]: event.target.value as UserProfile['role'] }))} className="rounded-lg border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 disabled:bg-slate-100">{Object.entries(roleLabels).map(([value,label]) => <option key={value} value={value}>{label}</option>)}</select></td>
                <td className="px-4 py-4 text-slate-500">{new Date(profile.created_at).toLocaleString('pt-BR')}</td>
                <td className="px-4 py-4"><div className="flex justify-end gap-2">{self ? <span className="inline-flex items-center gap-1 text-xs font-semibold text-emerald-700"><Check className="h-4 w-4"/> Protegida</span> : <><button onClick={() => void updateAccess(profile, 'approved')} disabled={savingId === profile.id} className="inline-flex items-center gap-1 rounded-lg bg-emerald-600 px-3 py-2 text-xs font-bold text-white hover:bg-emerald-700 disabled:opacity-50"><UserCheck className="h-4 w-4"/> Aprovar</button><button onClick={() => void updateAccess(profile, 'rejected')} disabled={savingId === profile.id} className="inline-flex items-center gap-1 rounded-lg border border-rose-200 bg-rose-50 px-3 py-2 text-xs font-bold text-rose-700 hover:bg-rose-100 disabled:opacity-50"><UserX className="h-4 w-4"/> Recusar</button></>}</div></td>
              </tr>;
            })}
          </tbody>
        </table>
      </div>
      {!loading && !profiles.length && <p className="p-10 text-center text-sm text-slate-500">Nenhum cadastro encontrado.</p>}
    </div>
  </div>;
};

const StatusBadge = ({ status }: { status: ApprovalStatus }) => {
  const style = status === 'approved' ? 'bg-emerald-100 text-emerald-800 border-emerald-200' : status === 'rejected' ? 'bg-rose-100 text-rose-800 border-rose-200' : 'bg-amber-100 text-amber-900 border-amber-200';
  const label = status === 'approved' ? 'Aprovado' : status === 'rejected' ? 'Recusado' : 'Aguardando aprovação';
  return <span className={`inline-flex rounded-full border px-2.5 py-1 text-xs font-bold ${style}`}>{label}</span>;
};
