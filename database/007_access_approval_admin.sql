begin;

alter table public.user_profiles
  add column if not exists email text,
  add column if not exists approval_status text not null default 'pending',
  add column if not exists approved_at timestamptz,
  add column if not exists approved_by uuid references auth.users(id),
  add column if not exists updated_at timestamptz not null default now();

alter table public.user_profiles drop constraint if exists user_profiles_approval_status_check;
alter table public.user_profiles add constraint user_profiles_approval_status_check
  check (approval_status in ('pending', 'approved', 'rejected'));

create or replace function public.is_marketops_admin(check_user_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.user_profiles
    where id = check_user_id and role = 'admin' and approval_status = 'approved'
  );
$$;

revoke all on function public.is_marketops_admin(uuid) from public;
grant execute on function public.is_marketops_admin(uuid) to authenticated;

drop policy if exists "Users can read their own profile" on public.user_profiles;
drop policy if exists "Users and admins can read profiles" on public.user_profiles;
drop policy if exists "Admins can read all profiles" on public.user_profiles;
drop policy if exists "Admins can update profiles" on public.user_profiles;

create policy "Users and admins can read profiles"
  on public.user_profiles for select to authenticated
  using (auth.uid() = id or public.is_marketops_admin(auth.uid()));

create policy "Admins can update profiles"
  on public.user_profiles for update to authenticated
  using (public.is_marketops_admin(auth.uid()))
  with check (public.is_marketops_admin(auth.uid()));

grant select, update on public.user_profiles to authenticated;
revoke insert, delete on public.user_profiles from anon, authenticated;

create or replace function public.handle_marketops_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  bootstrap_admin boolean := lower(coalesce(new.email, '')) = 'isabelakalidossame@gmail.com';
begin
  insert into public.user_profiles (id, email, role, approval_status, approved_at)
  values (
    new.id,
    lower(new.email),
    case when bootstrap_admin then 'admin' else 'viewer' end,
    case when bootstrap_admin then 'approved' else 'pending' end,
    case when bootstrap_admin then now() else null end
  )
  on conflict (id) do update set email = excluded.email, updated_at = now();
  return new;
end;
$$;

drop trigger if exists on_marketops_auth_user_created on auth.users;
create trigger on_marketops_auth_user_created
  after insert or update of email on auth.users
  for each row execute function public.handle_marketops_new_user();

insert into public.user_profiles (id, email, role, approval_status, approved_at)
select
  id,
  lower(email),
  case when lower(coalesce(email, '')) = 'isabelakalidossame@gmail.com' then 'admin' else 'viewer' end,
  case when lower(coalesce(email, '')) = 'isabelakalidossame@gmail.com' then 'approved' else 'pending' end,
  case when lower(coalesce(email, '')) = 'isabelakalidossame@gmail.com' then now() else null end
from auth.users
on conflict (id) do update set
  email = excluded.email,
  role = case when excluded.email = 'isabelakalidossame@gmail.com' then 'admin' else public.user_profiles.role end,
  approval_status = case when excluded.email = 'isabelakalidossame@gmail.com' then 'approved' else public.user_profiles.approval_status end,
  approved_at = case when excluded.email = 'isabelakalidossame@gmail.com' then now() else public.user_profiles.approved_at end,
  updated_at = now();

commit;
