begin;

create extension if not exists pgcrypto;

create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  purchase_order text not null unique,
  customer_order_id text not null,
  customer_name text not null,
  purchase_date date not null,
  seller text not null,
  seller_country text,
  status text not null check (status in ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
  status_text text,
  delivery_limit_days integer not null default 25 check (delivery_limit_days > 0),
  purchase_confirmed boolean not null default false,
  purchase_confirmed_at timestamptz,
  cancellation_reason text,
  cancelled_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  sequential text not null,
  material text not null,
  description text not null,
  gm9 text,
  supplier_material text,
  asin text,
  quantity integer not null check (quantity > 0),
  unit_measure text not null,
  vkp2_brl numeric(14,2) not null default 0,
  seller_unit_usd numeric(14,2) not null default 0,
  seller_total_usd numeric(14,2) not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (order_id, sequential, material)
);

create table if not exists public.logistics (
  id uuid primary key default gen_random_uuid(),
  order_item_id uuid not null unique references public.order_items(id) on delete cascade,
  marketplace_order_date date,
  marketplace_order_id text,
  account_group text,
  account_order_status text,
  account_user text,
  delivery_status text,
  expected_delivery_date date,
  carrier text,
  carrier_tracking text,
  wr_date date,
  warehouse_receipt text,
  eta date,
  etd date,
  invoice text unique,
  di_date date,
  entry_cd_date date,
  customer_delivery_date date,
  last_source_sync_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.order_events (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  order_item_id uuid references public.order_items(id) on delete cascade,
  event_type text not null,
  event_status text not null,
  event_location text,
  description text,
  occurred_at timestamptz not null,
  created_at timestamptz not null default now()
);

create table if not exists public.purchase_confirmation_history (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  confirmed boolean not null,
  confirmed_by text,
  confirmed_at timestamptz not null default now()
);

create table if not exists public.cancellation_history (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  reason text not null,
  source text not null default 'manual',
  cancelled_by text,
  cancelled_at timestamptz not null default now()
);

create index if not exists idx_orders_purchase_date on public.orders (purchase_date desc);
create index if not exists idx_orders_status on public.orders (status);
create index if not exists idx_orders_seller on public.orders (seller);
create index if not exists idx_orders_updated_at on public.orders (updated_at desc);
create index if not exists idx_order_items_order_id on public.order_items (order_id);
create index if not exists idx_logistics_invoice on public.logistics (invoice);
create index if not exists idx_logistics_delivery_date on public.logistics (customer_delivery_date);
create index if not exists idx_order_events_order_id on public.order_events (order_id, occurred_at desc);

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_orders_updated_at on public.orders;
create trigger set_orders_updated_at before update on public.orders
for each row execute function public.set_updated_at();

drop trigger if exists set_order_items_updated_at on public.order_items;
create trigger set_order_items_updated_at before update on public.order_items
for each row execute function public.set_updated_at();

drop trigger if exists set_logistics_updated_at on public.logistics;
create trigger set_logistics_updated_at before update on public.logistics
for each row execute function public.set_updated_at();

alter table public.orders enable row level security;
alter table public.order_items enable row level security;
alter table public.logistics enable row level security;
alter table public.order_events enable row level security;
alter table public.purchase_confirmation_history enable row level security;
alter table public.cancellation_history enable row level security;

revoke all on public.orders from anon, authenticated;
revoke all on public.order_items from anon, authenticated;
revoke all on public.logistics from anon, authenticated;
revoke all on public.order_events from anon, authenticated;
revoke all on public.purchase_confirmation_history from anon, authenticated;
revoke all on public.cancellation_history from anon, authenticated;

commit;
