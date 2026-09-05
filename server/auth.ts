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
        response.status(401).json({ error: 'Authentication required.' });
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
        response.status(401).json({ error: 'Invalid or expired session.' });
        return;
      }

      const user = await userResponse.json() as {
        id?: string;
        email?: string | null;
      };
      if (!user.id) {
        response.status(401).json({ error: 'Invalid user session.' });
        return;
      }

      const profileUrl = new URL(`${supabaseUrl}/rest/v1/user_profiles`);
      profileUrl.searchParams.set('id', `eq.${user.id}`);
      profileUrl.searchParams.set('select', 'role');
      const profileResponse = await fetch(profileUrl, { headers: authHeaders });
      if (!profileResponse.ok) {
        response.status(403).json({ error: 'User profile was not found.' });
        return;
      }

      const profiles = await profileResponse.json() as Array<{ role?: string }>;
      const role = profiles[0]?.role as UserRole | undefined;
      if (!role || !validRoles.includes(role)) {
        response.status(403).json({ error: 'User profile has an invalid role.' });
        return;
      }

      if (!allowedRoles.includes(role)) {
        response.status(403).json({ error: 'You do not have permission for this operation.' });
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
