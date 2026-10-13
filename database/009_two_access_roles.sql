begin;

-- MarketOps passa a ter apenas dois perfis de acesso:
--   admin  -> administra acessos e altera pedidos
--   viewer -> somente consulta de pedidos
update public.user_profiles
set role = 'viewer', updated_at = now()
where role not in ('admin', 'viewer');

alter table public.user_profiles drop constraint if exists user_profiles_role_check;
alter table public.user_profiles add constraint user_profiles_role_check
  check (role in ('admin', 'viewer'));

commit;
