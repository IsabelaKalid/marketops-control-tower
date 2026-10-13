import { supabase } from './supabase';

export async function apiFetch(
  input: RequestInfo | URL,
  init: RequestInit = {}
) {
  const session = supabase
    ? (await supabase.auth.getSession()).data.session
    : null;

  const headers = new Headers(init.headers);

  if (session?.access_token) {
    headers.set('Authorization', `Bearer ${session.access_token}`);
  }

  return fetch(input, {
    ...init,
    headers,
  });
}
