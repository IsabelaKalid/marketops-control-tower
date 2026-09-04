import type {
  NextFunction,
  Request,
  RequestHandler,
  Response,
} from 'express';
import { createClient } from '@supabase/supabase-js';

export type UserRole =
  | 'admin'
  | 'operations'
  | 'analyst'
  | 'viewer';

export interface AuthenticatedRequest extends Request {
  authUser?: {
    id: string;
    email: string | null;
    role: UserRole;
  };
}

function getBearerToken(request: Request) {
  const authorization = request.headers.authorization;

  if (!authorization?.startsWith('Bearer ')) {
    return null;
  }

  return authorization.slice('Bearer '.length).trim();
}

export function requireRoles(
  ...allowedRoles: UserRole[]
): RequestHandler {
  return async (
    request: AuthenticatedRequest,
    response: Response,
    next: NextFunction
  ) => {
    try {
      const token = getBearerToken(request);

      if (!token) {
        response.status(401).json({
          error: 'Authentication required.',
        });
        return;
      }

      const supabaseUrl = process.env.VITE_SUPABASE_URL;
      const publishableKey =
        process.env.VITE_SUPABASE_PUBLISHABLE_KEY;

      if (!supabaseUrl || !publishableKey) {
        response.status(503).json({
          error: 'Authentication service is not configured.',
        });
        return;
      }

      const requestClient = createClient(
        supabaseUrl,
        publishableKey,
        {
          global: {
            headers: {
              Authorization: `Bearer ${token}`,
            },
          },
          auth: {
            persistSession: false,
            autoRefreshToken: false,
          },
        }
      );

      const {
        data: { user },
        error: userError,
      } = await requestClient.auth.getUser(token);

      if (userError || !user) {
        response.status(401).json({
          error: 'Invalid or expired session.',
        });
        return;
      }

      const { data: profile, error: profileError } =
        await requestClient
          .from('user_profiles')
          .select('role')
          .eq('id', user.id)
          .single();

      if (profileError || !profile) {
        response.status(403).json({
          error: 'User profile was not found.',
        });
        return;
      }

      const role = profile.role as UserRole;

      if (!allowedRoles.includes(role)) {
        response.status(403).json({
          error: 'You do not have permission for this operation.',
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

      response.status(500).json({
        error: 'Could not validate the user session.',
      });
    }
  };
}