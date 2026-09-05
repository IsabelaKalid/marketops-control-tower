begin;

alter table public.orders
  add column if not exists purchase_confirmed boolean not null default false,
  add column if not exists purchase_confirmed_at timestamptz,
  add column if not exists cancellation_reason text,
  add column if not exists cancelled_at timestamptz,
  add column if not exists status_text text,
  add column if not exists updated_at timestamptz not null default now();

create table if not exists public.purchase_confirmation_history (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  confirmed boolean not null,
  confirmed_by text,
  confirmed_at timestamptz not null default now()
);

alter table public.purchase_confirmation_history
  add column if not exists confirmed boolean not null default true,
  add column if not exists confirmed_by text,
  add column if not exists confirmed_at timestamptz not null default now();

create table if not exists public.cancellation_history (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  reason text not null,
  source text not null default 'manual',
  cancelled_by text,
  cancelled_at timestamptz not null default now()
);

alter table public.cancellation_history
  add column if not exists reason text,
  add column if not exists source text not null default 'manual',
  add column if not exists cancelled_by text,
  add column if not exists cancelled_at timestamptz not null default now();

alter table public.purchase_confirmation_history enable row level security;
alter table public.cancellation_history enable row level security;

commit;
