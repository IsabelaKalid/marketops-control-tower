begin;

-- Contact fields used by automated customer delivery notifications.
-- Safe to run more than once.
alter table public.orders
  add column if not exists customer_email text,
  add column if not exists customer_phone text;

commit;
