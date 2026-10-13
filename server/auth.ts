import type { NextFunction, Request, RequestHandler, Response } from 'express';

export type UserRole = 'admin' | 'operations' | 'analyst' | 'viewer';

export interface AuthenticatedRequest extends Request {
  authUser?: {
    id: string;
    email: string | null;
    role: UserRole;
  };
}

const validRoles: UserRole[] = ['admin', 'operations', 'analyst', 'viewer'];

function getBearerToken(request: Request) {
  const authorization = request.headers.authorization;
  if (!authorization?.startsWith('Bearer ')) return null;
  return authorization.slice('Bearer '.length).trim();
}

export function requireRoles(...allowedRoles: UserRole[]): RequestHandler {
  return async (
    request: AuthenticatedRequest,
    response: Response,
    next: NextFunction,
  ) => {
    try {
      const token = getBearerToken(request);
      if (!token) {
        response.status(401).json({
          error: 'Você está usando o acesso de visitante, que permite apenas visualizar os dados. Entre com uma conta de Administrador ou Operações para realizar esta ação.',
          code: 'GUEST_READ_ONLY',
        });
        return;
      }

      const supabaseUrl = process.env.VITE_SUPABASE_URL?.replace(/\/$/, '');
      const publishableKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY;
      if (!supabaseUrl || !publishableKey) {
        response.status(503).json({ error: 'Authentication service is not configured.' });
        return;
      }

      const authHeaders = {
        apikey: publishableKey,
        Authorization: `Bearer ${token}`,
        Accept: 'application/json',
      };

      // Validate the token without initializing Supabase Realtime/WebSocket.
      const userResponse = await fetch(`${supabaseUrl}/auth/v1/user`, {
        headers: authHeaders,
      });
      if (!userResponse.ok) {
        response.status(401).json({
          error: 'Sua sessão expirou ou não é mais válida. Entre novamente para continuar.',
          code: 'SESSION_EXPIRED',
        });
        return;
      }

      const user = await userResponse.json() as {
        id?: string;
        email?: string | null;
      };
      if (!user.id) {
        response.status(401).json({
          error: 'Não foi possível identificar sua conta. Entre novamente para continuar.',
          code: 'INVALID_SESSION',
        });
        return;
      }

      const profileUrl = new URL(`${supabaseUrl}/rest/v1/user_profiles`);
      profileUrl.searchParams.set('id', `eq.${user.id}`);
      profileUrl.searchParams.set('select', 'role,approval_status');
      const profileResponse = await fetch(profileUrl, { headers: authHeaders });
      if (!profileResponse.ok) {
        response.status(403).json({
          error: 'Seu perfil de acesso não foi encontrado. Solicite ao administrador a liberação da sua conta.',
          code: 'PROFILE_NOT_FOUND',
        });
        return;
      }

      const profiles = await profileResponse.json() as Array<{ role?: string; approval_status?: string }>;
      const role = profiles[0]?.role as UserRole | undefined;
      if (!role || !validRoles.includes(role)) {
        response.status(403).json({
          error: 'Seu perfil não possui uma função de acesso válida. Solicite ao administrador a correção da sua permissão.',
          code: 'INVALID_ROLE',
        });
        return;
      }

      if (profiles[0]?.approval_status !== 'approved') {
        response.status(403).json({
          error: profiles[0]?.approval_status === 'rejected'
            ? 'Seu cadastro não foi aprovado pelo administrador do MarketOps.'
            : 'Seu cadastro está aguardando aprovação de um administrador do MarketOps.',
          code: profiles[0]?.approval_status === 'rejected' ? 'ACCESS_REJECTED' : 'APPROVAL_PENDING',
        });
        return;
      }

      if (!allowedRoles.includes(role)) {
        const isViewer = role === 'viewer';
        response.status(403).json({
          error: isViewer
            ? 'Seu perfil é Visitante e possui acesso somente para visualização. Entre com uma conta de Administrador ou Operações para realizar esta ação.'
            : 'Seu perfil atual não possui permissão para realizar esta ação. Solicite acesso ao administrador do MarketOps.',
          code: isViewer ? 'GUEST_READ_ONLY' : 'INSUFFICIENT_ROLE',
        });
        return;
      }

      request.authUser = {
        id: user.id,
        email: user.email || null,
        role,
      };
      next();
    } catch (error) {
      console.error('Authorization error:', error);
      response.status(500).json({ error: 'Could not validate the user session.' });
    }
  };
}
