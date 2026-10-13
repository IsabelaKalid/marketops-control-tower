begin;

alter table public.orders add column if not exists customer_cpf text;
alter table public.logistics add column if not exists billing_date date;

comment on column public.orders.customer_cpf is 'Customer CPF. Synthetic values may be used only in demonstration datasets.';
comment on column public.logistics.billing_date is 'Invoice/billing date; starts the customer out-for-delivery stage.';

commit;
