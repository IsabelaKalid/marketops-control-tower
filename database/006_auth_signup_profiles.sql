begin;

create table if not exists public.user_profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role text not null default 'viewer' check (role in ('admin', 'operations', 'analyst', 'viewer')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.user_profiles enable row level security;

drop policy if exists "Users can read their own profile" on public.user_profiles;
create policy "Users can read their own profile"
  on public.user_profiles for select
  to authenticated
  using (auth.uid() = id);

revoke insert, update, delete on public.user_profiles from anon, authenticated;
grant select on public.user_profiles to authenticated;

create or replace function public.handle_marketops_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.user_profiles (id, role)
  values (
    new.id,
    case
      when lower(coalesce(new.email, '')) = 'isabelakalidossame@gmail.com' then 'admin'
      else 'viewer'
    end
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_marketops_auth_user_created on auth.users;
create trigger on_marketops_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_marketops_new_user();

insert into public.user_profiles (id, role)
select
  id,
  case
    when lower(coalesce(email, '')) = 'isabelakalidossame@gmail.com' then 'admin'
    else 'viewer'
  end
from auth.users
on conflict (id) do update
set role = case
  when excluded.role = 'admin' then 'admin'
  else public.user_profiles.role
end,
updated_at = now();

commit;
