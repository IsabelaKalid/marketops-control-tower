select
  (select count(*) from public.orders) as orders,
  (select count(*) from public.order_items) as order_items,
  (select count(*) from public.logistics) as logistics;
