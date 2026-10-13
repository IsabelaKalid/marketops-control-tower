-- Persist the customer destination supplied by Databricks.
-- Safe to run more than once.
alter table if exists public.logistics
  add column if not exists destination text;

create index if not exists idx_logistics_destination
  on public.logistics (destination);
