begin;

alter table public.orders add column if not exists customer_address text;
alter table public.orders add column if not exists customer_city text;
alter table public.orders add column if not exists customer_state text;

comment on column public.orders.customer_address is 'Full customer delivery address for operational export and Databricks integration.';
comment on column public.orders.customer_city is 'Customer delivery city; safe summary shown in the interface.';
comment on column public.orders.customer_state is 'Customer delivery state/UF; safe summary shown in the interface.';

commit;
