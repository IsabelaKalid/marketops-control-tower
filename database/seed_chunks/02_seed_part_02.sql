-- Demo seed part 02 of 10. Run files in numeric order.
begin;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80163', '900004727', 'Daniel Ibrahim Costa', '2026-05-23'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-05-24'::timestamptz, null, null::timestamptz, '2026-05-23T09:00:00.000Z'::timestamptz, '2026-06-16T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80164', '900004756', 'Elisa Ibrahim Costa', '2026-05-24'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-05-26'::timestamptz, null, null::timestamptz, '2026-05-24T09:00:00.000Z'::timestamptz, '2026-06-17T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80165', '900004785', 'Felipe Ibrahim Costa', '2026-05-25'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-05-25'::timestamptz, null, null::timestamptz, '2026-05-25T09:00:00.000Z'::timestamptz, '2026-06-13T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80166', '900004814', 'Gabriela Ibrahim Costa', '2026-05-25'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-05-26'::timestamptz, null, null::timestamptz, '2026-05-25T09:00:00.000Z'::timestamptz, '2026-06-17T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80167', '900004843', 'Heitor Ibrahim Costa', '2026-05-26'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-05-28'::timestamptz, null, null::timestamptz, '2026-05-26T09:00:00.000Z'::timestamptz, '2026-06-24T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80168', '900004872', 'Isadora Ibrahim Costa', '2026-05-27'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-05-27'::timestamptz, null, null::timestamptz, '2026-05-27T09:00:00.000Z'::timestamptz, '2026-06-12T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80169', '900004901', 'João Miguel Ibrahim Costa', '2026-05-28'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-05-29'::timestamptz, null, null::timestamptz, '2026-05-28T09:00:00.000Z'::timestamptz, '2026-06-19T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80170', '900004930', 'Larissa Ibrahim Costa', '2026-05-29'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-05-31'::timestamptz, null, null::timestamptz, '2026-05-29T09:00:00.000Z'::timestamptz, '2026-06-19T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80171', '900004959', 'Mateus Ibrahim Costa', '2026-05-30'::date, 'Walmart', 'USA', 'Shipped', null,
  25, true, '2026-05-30'::timestamptz, null, null::timestamptz, '2026-05-30T09:00:00.000Z'::timestamptz, '2026-06-13T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80172', '900004988', 'Natália Ibrahim Costa', '2026-05-30'::date, 'eBay', 'USA', 'Shipped', null,
  25, true, '2026-05-31'::timestamptz, null, null::timestamptz, '2026-05-30T09:00:00.000Z'::timestamptz, '2026-06-16T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80173', '900005017', 'Otávio Ibrahim Costa', '2026-05-31'::date, 'Target', 'USA', 'Shipped', null,
  25, true, '2026-06-02'::timestamptz, null, null::timestamptz, '2026-05-31T09:00:00.000Z'::timestamptz, '2026-06-20T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80174', '900005046', 'Paula Ibrahim Costa', '2026-06-01'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-06-01'::timestamptz, null, null::timestamptz, '2026-06-01T09:00:00.000Z'::timestamptz, '2026-06-21T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80175', '900005075', 'Rafael Ibrahim Costa', '2026-06-02'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-06-03'::timestamptz, null, null::timestamptz, '2026-06-02T09:00:00.000Z'::timestamptz, '2026-06-13T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80176', '900005104', 'Sofia Ibrahim Costa', '2026-06-03'::date, 'Amazon', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-06-03T09:00:00.000Z'::timestamptz, '2026-06-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80177', '900005133', 'Tiago Ibrahim Costa', '2026-06-04'::date, 'Walmart', 'USA', 'Pending', null,
  25, true, '2026-06-04'::timestamptz, null, null::timestamptz, '2026-06-04T09:00:00.000Z'::timestamptz, '2026-06-04T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80178', '900005162', 'Vitória Ibrahim Costa', '2026-06-05'::date, 'eBay', 'USA', 'Pending', null,
  25, true, '2026-06-06'::timestamptz, null, null::timestamptz, '2026-06-05T09:00:00.000Z'::timestamptz, '2026-06-06T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80179', '900005191', 'William Ibrahim Costa', '2026-06-05'::date, 'Target', 'USA', 'Pending', null,
  25, true, '2026-06-07'::timestamptz, null, null::timestamptz, '2026-06-05T09:00:00.000Z'::timestamptz, '2026-06-07T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80180', '900005220', 'Ana Clara Jardim Ribeiro', '2026-06-06'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-06-07'::timestamptz, '2026-06-06T09:00:00.000Z'::timestamptz, '2026-06-07T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80181', '900005249', 'Bruno Jardim Ribeiro', '2026-06-07'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo customer', '2026-06-09'::timestamptz, '2026-06-07T09:00:00.000Z'::timestamptz, '2026-06-09T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80182', '900005278', 'Camila Jardim Ribeiro', '2026-06-08'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-06-11'::timestamptz, '2026-06-08T09:00:00.000Z'::timestamptz, '2026-06-11T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80183', '900005307', 'Daniel Jardim Ribeiro', '2026-06-09'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-06-09'::timestamptz, null, null::timestamptz, '2026-06-09T09:00:00.000Z'::timestamptz, '2026-06-30T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80184', '900005336', 'Elisa Jardim Ribeiro', '2026-06-10'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-06-11'::timestamptz, null, null::timestamptz, '2026-06-10T09:00:00.000Z'::timestamptz, '2026-07-01T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80185', '900005365', 'Felipe Jardim Ribeiro', '2026-06-10'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-06-12'::timestamptz, null, null::timestamptz, '2026-06-10T09:00:00.000Z'::timestamptz, '2026-07-02T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80186', '900005394', 'Gabriela Jardim Ribeiro', '2026-06-11'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-06-11'::timestamptz, null, null::timestamptz, '2026-06-11T09:00:00.000Z'::timestamptz, '2026-07-01T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80187', '900005423', 'Heitor Jardim Ribeiro', '2026-06-12'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-06-13'::timestamptz, null, null::timestamptz, '2026-06-12T09:00:00.000Z'::timestamptz, '2026-07-08T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80188', '900005452', 'Isadora Jardim Ribeiro', '2026-06-13'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-06-15'::timestamptz, null, null::timestamptz, '2026-06-13T09:00:00.000Z'::timestamptz, '2026-07-09T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80189', '900005481', 'João Miguel Jardim Ribeiro', '2026-06-14'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-06-14'::timestamptz, null, null::timestamptz, '2026-06-14T09:00:00.000Z'::timestamptz, '2026-07-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80190', '900005510', 'Larissa Jardim Ribeiro', '2026-06-15'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-06-16'::timestamptz, null, null::timestamptz, '2026-06-15T09:00:00.000Z'::timestamptz, '2026-07-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80191', '900005539', 'Mateus Jardim Ribeiro', '2026-06-16'::date, 'Target', 'USA', 'Shipped', null,
  25, true, '2026-06-18'::timestamptz, null, null::timestamptz, '2026-06-16T09:00:00.000Z'::timestamptz, '2026-07-01T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80192', '900005568', 'Natália Jardim Ribeiro', '2026-06-16'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-06-16'::timestamptz, null, null::timestamptz, '2026-06-16T09:00:00.000Z'::timestamptz, '2026-07-01T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80193', '900005597', 'Otávio Jardim Ribeiro', '2026-06-17'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-06-18'::timestamptz, null, null::timestamptz, '2026-06-17T09:00:00.000Z'::timestamptz, '2026-07-05T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80194', '900005626', 'Paula Jardim Ribeiro', '2026-06-18'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-06-20'::timestamptz, null, null::timestamptz, '2026-06-18T09:00:00.000Z'::timestamptz, '2026-07-09T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80195', '900005655', 'Rafael Jardim Ribeiro', '2026-06-19'::date, 'Walmart', 'USA', 'Shipped', null,
  25, true, '2026-06-19'::timestamptz, null, null::timestamptz, '2026-06-19T09:00:00.000Z'::timestamptz, '2026-07-05T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80196', '900005684', 'Sofia Jardim Ribeiro', '2026-06-20'::date, 'eBay', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-06-20T09:00:00.000Z'::timestamptz, '2026-06-20T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80197', '900005713', 'Tiago Jardim Ribeiro', '2026-06-21'::date, 'Target', 'USA', 'Pending', null,
  25, true, '2026-06-23'::timestamptz, null, null::timestamptz, '2026-06-21T09:00:00.000Z'::timestamptz, '2026-06-23T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80198', '900005742', 'Vitória Jardim Ribeiro', '2026-06-22'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-06-22'::timestamptz, null, null::timestamptz, '2026-06-22T09:00:00.000Z'::timestamptz, '2026-06-22T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80199', '900005771', 'William Jardim Ribeiro', '2026-06-22'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-06-23'::timestamptz, null, null::timestamptz, '2026-06-22T09:00:00.000Z'::timestamptz, '2026-06-23T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80200', '900005800', 'Ana Clara Klein Martins', '2026-06-23'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-06-24'::timestamptz, '2026-06-23T09:00:00.000Z'::timestamptz, '2026-06-24T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80201', '900005829', 'Bruno Klein Martins', '2026-06-24'::date, 'Walmart', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo customer', '2026-06-26'::timestamptz, '2026-06-24T09:00:00.000Z'::timestamptz, '2026-06-26T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80202', '900005858', 'Camila Klein Martins', '2026-06-25'::date, 'eBay', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-06-28'::timestamptz, '2026-06-25T09:00:00.000Z'::timestamptz, '2026-06-28T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80203', '900005887', 'Daniel Klein Martins', '2026-06-26'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-06-28'::timestamptz, null, null::timestamptz, '2026-06-26T09:00:00.000Z'::timestamptz, '2026-07-20T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80204', '900005916', 'Elisa Klein Martins', '2026-06-27'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-06-27'::timestamptz, null, null::timestamptz, '2026-06-27T09:00:00.000Z'::timestamptz, '2026-07-15T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80205', '900005945', 'Felipe Klein Martins', '2026-06-27'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-06-28'::timestamptz, null, null::timestamptz, '2026-06-27T09:00:00.000Z'::timestamptz, '2026-07-16T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80206', '900005974', 'Gabriela Klein Martins', '2026-06-28'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-06-30'::timestamptz, null, null::timestamptz, '2026-06-28T09:00:00.000Z'::timestamptz, '2026-07-21T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80207', '900006003', 'Heitor Klein Martins', '2026-06-29'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-06-29'::timestamptz, null, null::timestamptz, '2026-06-29T09:00:00.000Z'::timestamptz, '2026-07-22T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80208', '900006032', 'Isadora Klein Martins', '2026-06-30'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-07-01'::timestamptz, null, null::timestamptz, '2026-06-30T09:00:00.000Z'::timestamptz, '2026-07-23T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80209', '900006061', 'João Miguel Klein Martins', '2026-07-01'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-07-03'::timestamptz, null, null::timestamptz, '2026-07-01T09:00:00.000Z'::timestamptz, '2026-07-30T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80210', '900006090', 'Larissa Klein Martins', '2026-07-02'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-07-02'::timestamptz, null, null::timestamptz, '2026-07-02T09:00:00.000Z'::timestamptz, '2026-07-17T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80211', '900006119', 'Mateus Klein Martins', '2026-07-03'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-07-04'::timestamptz, null, null::timestamptz, '2026-07-03T09:00:00.000Z'::timestamptz, '2026-07-16T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80212', '900006148', 'Natália Klein Martins', '2026-07-03'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-07-05'::timestamptz, null, null::timestamptz, '2026-07-03T09:00:00.000Z'::timestamptz, '2026-07-19T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80213', '900006177', 'Otávio Klein Martins', '2026-07-04'::date, 'Walmart', 'USA', 'Shipped', null,
  25, true, '2026-07-04'::timestamptz, null, null::timestamptz, '2026-07-04T09:00:00.000Z'::timestamptz, '2026-07-20T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80214', '900006206', 'Paula Klein Martins', '2026-07-05'::date, 'eBay', 'USA', 'Shipped', null,
  25, true, '2026-07-06'::timestamptz, null, null::timestamptz, '2026-07-05T09:00:00.000Z'::timestamptz, '2026-07-24T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80215', '900006235', 'Rafael Klein Martins', '2026-07-06'::date, 'Target', 'USA', 'Shipped', null,
  25, true, '2026-07-08'::timestamptz, null, null::timestamptz, '2026-07-06T09:00:00.000Z'::timestamptz, '2026-07-23T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80216', '900006264', 'Sofia Klein Martins', '2026-07-07'::date, 'Amazon', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-07-07T09:00:00.000Z'::timestamptz, '2026-07-07T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80217', '900006293', 'Tiago Klein Martins', '2026-07-08'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-07-09'::timestamptz, null, null::timestamptz, '2026-07-08T09:00:00.000Z'::timestamptz, '2026-07-09T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80218', '900006322', 'Vitória Klein Martins', '2026-07-08'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-07-10'::timestamptz, null, null::timestamptz, '2026-07-08T09:00:00.000Z'::timestamptz, '2026-07-10T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80219', '900006351', 'William Klein Martins', '2026-07-09'::date, 'Walmart', 'USA', 'Pending', null,
  25, true, '2026-07-09'::timestamptz, null, null::timestamptz, '2026-07-09T09:00:00.000Z'::timestamptz, '2026-07-09T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80220', '900006380', 'Ana Clara Lopes Azevedo', '2026-07-10'::date, 'eBay', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-07-11'::timestamptz, '2026-07-10T09:00:00.000Z'::timestamptz, '2026-07-11T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80221', '900006409', 'Bruno Lopes Azevedo', '2026-07-11'::date, 'Target', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo customer', '2026-07-13'::timestamptz, '2026-07-11T09:00:00.000Z'::timestamptz, '2026-07-13T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80222', '900006438', 'Camila Lopes Azevedo', '2026-07-12'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-07-15'::timestamptz, '2026-07-12T09:00:00.000Z'::timestamptz, '2026-07-15T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80223', '900006467', 'Daniel Lopes Azevedo', '2026-07-13'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-07-14'::timestamptz, null, null::timestamptz, '2026-07-13T09:00:00.000Z'::timestamptz, '2026-08-10T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80224', '900006496', 'Elisa Lopes Azevedo', '2026-07-14'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-07-16'::timestamptz, null, null::timestamptz, '2026-07-14T09:00:00.000Z'::timestamptz, '2026-08-04T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80225', '900006525', 'Felipe Lopes Azevedo', '2026-07-14'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-07-14'::timestamptz, null, null::timestamptz, '2026-07-14T09:00:00.000Z'::timestamptz, '2026-07-30T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80226', '900006554', 'Gabriela Lopes Azevedo', '2026-07-15'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-07-16'::timestamptz, null, null::timestamptz, '2026-07-15T09:00:00.000Z'::timestamptz, '2026-08-04T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80227', '900006583', 'Heitor Lopes Azevedo', '2026-07-16'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-07-18'::timestamptz, null, null::timestamptz, '2026-07-16T09:00:00.000Z'::timestamptz, '2026-08-11T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80228', '900006612', 'Isadora Lopes Azevedo', '2026-07-17'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-07-17'::timestamptz, null, null::timestamptz, '2026-07-17T09:00:00.000Z'::timestamptz, '2026-08-06T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80229', '900006641', 'João Miguel Lopes Azevedo', '2026-07-18'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-07-19'::timestamptz, null, null::timestamptz, '2026-07-18T09:00:00.000Z'::timestamptz, '2026-08-13T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80230', '900006670', 'Larissa Lopes Azevedo', '2026-07-19'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-07-21'::timestamptz, null, null::timestamptz, '2026-07-19T09:00:00.000Z'::timestamptz, '2026-08-13T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80231', '900006699', 'Mateus Lopes Azevedo', '2026-07-20'::date, 'Walmart', 'USA', 'Shipped', null,
  25, true, '2026-07-20'::timestamptz, null, null::timestamptz, '2026-07-20T09:00:00.000Z'::timestamptz, '2026-07-31T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80232', '900006728', 'Natália Lopes Azevedo', '2026-07-20'::date, 'eBay', 'USA', 'Shipped', null,
  25, true, '2026-07-21'::timestamptz, null, null::timestamptz, '2026-07-20T09:00:00.000Z'::timestamptz, '2026-08-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80233', '900006757', 'Otávio Lopes Azevedo', '2026-07-21'::date, 'Target', 'USA', 'Shipped', null,
  25, true, '2026-07-23'::timestamptz, null, null::timestamptz, '2026-07-21T09:00:00.000Z'::timestamptz, '2026-08-07T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80234', '900006786', 'Paula Lopes Azevedo', '2026-07-22'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-07-22'::timestamptz, null, null::timestamptz, '2026-07-22T09:00:00.000Z'::timestamptz, '2026-08-08T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80235', '900006815', 'Rafael Lopes Azevedo', '2026-07-23'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-07-24'::timestamptz, null, null::timestamptz, '2026-07-23T09:00:00.000Z'::timestamptz, '2026-08-07T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80236', '900006844', 'Sofia Lopes Azevedo', '2026-07-24'::date, 'Amazon', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-07-24T09:00:00.000Z'::timestamptz, '2026-07-24T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80237', '900006873', 'Tiago Lopes Azevedo', '2026-07-25'::date, 'Walmart', 'USA', 'Pending', null,
  25, true, '2026-07-25'::timestamptz, null, null::timestamptz, '2026-07-25T09:00:00.000Z'::timestamptz, '2026-07-25T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80238', '900006902', 'Vitória Lopes Azevedo', '2026-07-25'::date, 'eBay', 'USA', 'Pending', null,
  25, true, '2026-07-26'::timestamptz, null, null::timestamptz, '2026-07-25T09:00:00.000Z'::timestamptz, '2026-07-26T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80239', '900006931', 'William Lopes Azevedo', '2026-07-26'::date, 'Target', 'USA', 'Pending', null,
  25, true, '2026-07-28'::timestamptz, null, null::timestamptz, '2026-07-26T09:00:00.000Z'::timestamptz, '2026-07-28T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80240', '900006960', 'Ana Clara Macedo Rocha', '2026-07-27'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-07-28'::timestamptz, '2026-07-27T09:00:00.000Z'::timestamptz, '2026-07-28T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80241', '900006989', 'Bruno Macedo Rocha', '2026-07-28'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo customer', '2026-07-30'::timestamptz, '2026-07-28T09:00:00.000Z'::timestamptz, '2026-07-30T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80242', '900007018', 'Camila Macedo Rocha', '2026-07-29'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-08-01'::timestamptz, '2026-07-29T09:00:00.000Z'::timestamptz, '2026-08-01T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80243', '900007047', 'Daniel Macedo Rocha', '2026-07-30'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-07-30'::timestamptz, null, null::timestamptz, '2026-07-30T09:00:00.000Z'::timestamptz, '2026-08-24T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80244', '900007076', 'Elisa Macedo Rocha', '2026-07-31'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-08-01'::timestamptz, null, null::timestamptz, '2026-07-31T09:00:00.000Z'::timestamptz, '2026-08-25T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80245', '900007105', 'Felipe Macedo Rocha', '2026-07-31'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-08-02'::timestamptz, null, null::timestamptz, '2026-07-31T09:00:00.000Z'::timestamptz, '2026-08-19T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80246', '900007134', 'Gabriela Macedo Rocha', '2026-08-01'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-08-01'::timestamptz, null, null::timestamptz, '2026-08-01T09:00:00.000Z'::timestamptz, '2026-08-18T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80247', '900007163', 'Heitor Macedo Rocha', '2026-08-02'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-08-03'::timestamptz, null, null::timestamptz, '2026-08-02T09:00:00.000Z'::timestamptz, '2026-08-25T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80248', '900007192', 'Isadora Macedo Rocha', '2026-08-03'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-08-05'::timestamptz, null, null::timestamptz, '2026-08-03T09:00:00.000Z'::timestamptz, '2026-08-26T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80249', '900007221', 'João Miguel Macedo Rocha', '2026-08-04'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-08-04'::timestamptz, null, null::timestamptz, '2026-08-04T09:00:00.000Z'::timestamptz, '2026-08-27T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80250', '900007250', 'Larissa Macedo Rocha', '2026-08-05'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-08-06'::timestamptz, null, null::timestamptz, '2026-08-05T09:00:00.000Z'::timestamptz, '2026-08-27T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80251', '900007279', 'Mateus Macedo Rocha', '2026-08-05'::date, 'Target', 'USA', 'Shipped', null,
  25, true, '2026-08-07'::timestamptz, null, null::timestamptz, '2026-08-05T09:00:00.000Z'::timestamptz, '2026-08-24T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80252', '900007308', 'Natália Macedo Rocha', '2026-08-06'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-08-06'::timestamptz, null, null::timestamptz, '2026-08-06T09:00:00.000Z'::timestamptz, '2026-08-18T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80253', '900007337', 'Otávio Macedo Rocha', '2026-08-07'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-08-08'::timestamptz, null, null::timestamptz, '2026-08-07T09:00:00.000Z'::timestamptz, '2026-08-22T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80254', '900007366', 'Paula Macedo Rocha', '2026-08-08'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-08-10'::timestamptz, null, null::timestamptz, '2026-08-08T09:00:00.000Z'::timestamptz, '2026-08-26T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80255', '900007395', 'Rafael Macedo Rocha', '2026-08-09'::date, 'Walmart', 'USA', 'Shipped', null,
  25, true, '2026-08-09'::timestamptz, null, null::timestamptz, '2026-08-09T09:00:00.000Z'::timestamptz, '2026-08-22T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80256', '900007424', 'Sofia Macedo Rocha', '2026-08-10'::date, 'eBay', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-08-10T09:00:00.000Z'::timestamptz, '2026-08-10T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80257', '900007453', 'Tiago Macedo Rocha', '2026-08-11'::date, 'Target', 'USA', 'Pending', null,
  25, true, '2026-08-13'::timestamptz, null, null::timestamptz, '2026-08-11T09:00:00.000Z'::timestamptz, '2026-08-13T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80258', '900007482', 'Vitória Macedo Rocha', '2026-08-11'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-08-11'::timestamptz, null, null::timestamptz, '2026-08-11T09:00:00.000Z'::timestamptz, '2026-08-11T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80259', '900007511', 'William Macedo Rocha', '2026-08-12'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-08-13'::timestamptz, null, null::timestamptz, '2026-08-12T09:00:00.000Z'::timestamptz, '2026-08-13T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80260', '900007540', 'Ana Clara Neves Andrade', '2026-08-13'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-08-14'::timestamptz, '2026-08-13T09:00:00.000Z'::timestamptz, '2026-08-14T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80261', '900007569', 'Bruno Neves Andrade', '2026-08-14'::date, 'Walmart', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo customer', '2026-08-16'::timestamptz, '2026-08-14T09:00:00.000Z'::timestamptz, '2026-08-16T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80262', '900007598', 'Camila Neves Andrade', '2026-08-15'::date, 'eBay', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-08-18'::timestamptz, '2026-08-15T09:00:00.000Z'::timestamptz, '2026-08-18T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80263', '900007627', 'Daniel Neves Andrade', '2026-08-16'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-08-18'::timestamptz, null, null::timestamptz, '2026-08-16T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80264', '900007656', 'Elisa Neves Andrade', '2026-08-17'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-08-17'::timestamptz, null, null::timestamptz, '2026-08-17T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80265', '900007685', 'Felipe Neves Andrade', '2026-08-17'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-08-18'::timestamptz, null, null::timestamptz, '2026-08-17T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80266', '900007714', 'Gabriela Neves Andrade', '2026-08-18'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-08-20'::timestamptz, null, null::timestamptz, '2026-08-18T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80267', '900007743', 'Heitor Neves Andrade', '2026-08-19'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-08-19'::timestamptz, null, null::timestamptz, '2026-08-19T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80268', '900007772', 'Isadora Neves Andrade', '2026-08-20'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-08-21'::timestamptz, null, null::timestamptz, '2026-08-20T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80269', '900007801', 'João Miguel Neves Andrade', '2026-08-21'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-08-23'::timestamptz, null, null::timestamptz, '2026-08-21T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80270', '900007830', 'Larissa Neves Andrade', '2026-08-22'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-08-22'::timestamptz, null, null::timestamptz, '2026-08-22T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80271', '900007859', 'Mateus Neves Andrade', '2026-08-22'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-08-23'::timestamptz, null, null::timestamptz, '2026-08-22T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80272', '900007888', 'Natália Neves Andrade', '2026-08-23'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-08-25'::timestamptz, null, null::timestamptz, '2026-08-23T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80273', '900007917', 'Otávio Neves Andrade', '2026-08-24'::date, 'Walmart', 'USA', 'Shipped', null,
  25, true, '2026-08-24'::timestamptz, null, null::timestamptz, '2026-08-24T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80274', '900007946', 'Paula Neves Andrade', '2026-08-25'::date, 'eBay', 'USA', 'Shipped', null,
  25, true, '2026-08-26'::timestamptz, null, null::timestamptz, '2026-08-25T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80275', '900007975', 'Rafael Neves Andrade', '2026-08-26'::date, 'Target', 'USA', 'Shipped', null,
  25, true, '2026-08-28'::timestamptz, null, null::timestamptz, '2026-08-26T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80276', '900008004', 'Sofia Neves Andrade', '2026-08-27'::date, 'Amazon', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-08-27T09:00:00.000Z'::timestamptz, '2026-08-27T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80277', '900008033', 'Tiago Neves Andrade', '2026-08-28'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-08-29'::timestamptz, null, null::timestamptz, '2026-08-28T09:00:00.000Z'::timestamptz, '2026-08-29T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80278', '900008062', 'Vitória Neves Andrade', '2026-08-28'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-08-30'::timestamptz, null, null::timestamptz, '2026-08-28T09:00:00.000Z'::timestamptz, '2026-08-30T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80279', '900008091', 'William Neves Andrade', '2026-08-29'::date, 'Walmart', 'USA', 'Pending', null,
  25, true, '2026-08-29'::timestamptz, null, null::timestamptz, '2026-08-29T09:00:00.000Z'::timestamptz, '2026-08-29T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80280', '900008120', 'Ana Clara Oliveira Bastos', '2026-08-30'::date, 'eBay', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-08-30T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80281', '900008149', 'Bruno Oliveira Bastos', '2026-08-31'::date, 'Target', 'USA', 'Pending', null,
  25, true, '2026-09-02'::timestamptz, null, null::timestamptz, '2026-08-31T09:00:00.000Z'::timestamptz, '2026-09-02T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80282', '900008178', 'Camila Oliveira Bastos', '2026-09-01'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-09-01'::timestamptz, null, null::timestamptz, '2026-09-01T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80283', '900008207', 'Daniel Oliveira Bastos', '2026-09-02'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-09-03'::timestamptz, null, null::timestamptz, '2026-09-02T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80284', '900008236', 'Elisa Oliveira Bastos', '2026-09-03'::date, 'Amazon', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-09-03T09:00:00.000Z'::timestamptz, '2026-09-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '222-232', 'NOVAMARK MARCADOR DE TEXTO COLORIDO PONTA CHANFRADA KIT COM 12 CORES - ITEM 1', 'GM9-000001', 'SUP-540000', 'B0WXXCW78W', 2, 'EA', 74.8, 8.5, 17
from public.orders where purchase_order = 'AKDN-80000'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Cancelled', 'Marina Torres',
  'Cancelled', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80000' and oi.sequential = '10' and oi.material = '222-232'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '20', '222-249', 'PULSE AUDIO CAIXA DE SOM BLUETOOTH PORTÁTIL RESISTENTE À ÁGUA - ITEM 2', 'GM9-000002', 'SUP-540011', 'B0XWLLEJM4', 1, 'EA', 40.09, 8.87, 8.87
from public.orders where purchase_order = 'AKDN-80000'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Cancelled', 'Marina Torres',
  'Cancelled', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80000' and oi.sequential = '20' and oi.material = '222-249'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '222-266', 'CLOUD REST TRAVESSEIRO VISCOELÁSTICO ORTOPÉDICO COM CAPA LAVÁVEL - ITEM 1', 'GM9-000003', 'SUP-540022', 'B0YW8TWV2B', 2, 'EA', 85.75, 9.24, 18.48
from public.orders where purchase_order = 'AKDN-80001'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Cancelled', 'Caio Nunes',
  'Cancelled', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80001' and oi.sequential = '10' and oi.material = '222-266'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '20', '222-283', 'LUMINA HOME LUMINÁRIA DE MESA LED ARTICULADA COM CONTROLE DE INTENSIDADE - ITEM 2', 'GM9-000004', 'SUP-540033', 'B0ZVU3E9FJ', 1, 'EA', 45.74, 9.61, 9.61
from public.orders where purchase_order = 'AKDN-80001'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Cancelled', 'Caio Nunes',
  'Cancelled', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80001' and oi.sequential = '20' and oi.material = '222-283'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '222-300', 'NEXUS TECH DOCK STATION USB-C COM HDMI LEITOR DE CARTÃO E REDE GIGABIT - ITEM 1', 'GM9-000005', 'SUP-540044', 'B02UGBXLUR', 2, 'EA', 97.4, 9.98, 19.96
from public.orders where purchase_order = 'AKDN-80002'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Cancelled', 'Renata Alves',
  'Cancelled', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80002' and oi.sequential = '10' and oi.material = '222-300'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '20', '222-317', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA - ITEM 2', 'GM9-000006', 'SUP-540055', 'B03U4JFXAY', 1, 'EA', 51.75, 10.35, 10.35
from public.orders where purchase_order = 'AKDN-80002'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Cancelled', 'Renata Alves',
  'Cancelled', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80002' and oi.sequential = '20' and oi.material = '222-317'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '222-334', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO - ITEM 1', 'GM9-000007', 'SUP-540066', 'B05TQSXAP7', 2, 'EA', 109.77, 10.72, 21.44
from public.orders where purchase_order = 'AKDN-80003'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-01-07'::date, '113-1000111-2000186', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-01-23'::date, 'UPS Demo', 'DEMO00000401', '2026-01-15'::date, 'RCPT-073006', '2026-01-23'::date, '2026-01-16'::date, 'NX-041006-26',
  '2026-01-24'::date, '2026-01-26'::date, '2026-01-30'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80003' and oi.sequential = '10' and oi.material = '222-334'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'af138dbd-e71e-40e9-ba38-facbe4129cf4'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-01-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80003' and oi.sequential = '10' and oi.material = '222-334'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '86c74022-2490-4995-bd37-6e35d62c00af'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-01-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80003' and oi.sequential = '10' and oi.material = '222-334'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0a79f245-f430-43d7-9593-e3a5cd5bcc06'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-01-23'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80003' and oi.sequential = '10' and oi.material = '222-334'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '971f10a6-4879-4230-987e-839c14d75da0'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-01-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80003' and oi.sequential = '10' and oi.material = '222-334'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '878a501a-42e5-4ddc-aea1-f011f0fe613b'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-01-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80003' and oi.sequential = '10' and oi.material = '222-334'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '20', '222-351', 'PIXELKEY TECLADO SEM FIO COMPACTO COM TECLAS SILENCIOSAS - ITEM 2', 'GM9-000008', 'SUP-540077', 'B06SC2FM4D', 1, 'EA', 48.8, 11.09, 11.09
from public.orders where purchase_order = 'AKDN-80003'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-01-07'::date, '113-1000111-2000217', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-01-24'::date, 'UPS Demo', 'DEMO00000402', '2026-01-16'::date, 'RCPT-073007', '2026-01-24'::date, '2026-01-17'::date, 'NX-041007-26',
  '2026-01-25'::date, '2026-01-27'::date, '2026-01-31'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80003' and oi.sequential = '20' and oi.material = '222-351'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '19de27f7-e8ab-494d-af2f-23351ea081f2'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-01-31'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80003' and oi.sequential = '20' and oi.material = '222-351'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '30827f01-aa81-4c23-80b8-2856a80be2ad'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-01-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80003' and oi.sequential = '20' and oi.material = '222-351'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'ffc1cac3-8db0-4a2e-b31f-e000fbbfd022'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-01-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80003' and oi.sequential = '20' and oi.material = '222-351'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '623e3fcf-1097-4e20-a234-a8f3ae31b671'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-01-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80003' and oi.sequential = '20' and oi.material = '222-351'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'af153bcd-c487-4eb6-8fdc-085596c2e139'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-01-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80003' and oi.sequential = '20' and oi.material = '222-351'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '222-368', 'NOVAMARK MARCADOR DE TEXTO COLORIDO PONTA CHANFRADA KIT COM 12 CORES - ITEM 1', 'GM9-000009', 'SUP-540088', 'B07SY9YYHL', 2, 'EA', 103.6, 11.46, 22.92
from public.orders where purchase_order = 'AKDN-80004'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-01-09'::date, '113-1000148-2000248', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-01-27'::date, 'FedEx Demo', 'DEMO00000501', '2026-01-17'::date, 'RCPT-073008', '2026-01-27'::date, '2026-01-19'::date, 'NX-041008-26',
  '2026-01-29'::date, '2026-01-30'::date, '2026-01-31'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80004' and oi.sequential = '10' and oi.material = '222-368'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '8c085013-e903-43f5-b00a-afa6e238cf11'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-01-31'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80004' and oi.sequential = '10' and oi.material = '222-368'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0c5323c3-af1c-409a-8886-07d64b5474fa'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-01-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80004' and oi.sequential = '10' and oi.material = '222-368'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7d278925-fde4-4263-b665-b40a4590bf78'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-01-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80004' and oi.sequential = '10' and oi.material = '222-368'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4aa066e8-6d24-42a5-8895-83069766f084'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-01-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80004' and oi.sequential = '10' and oi.material = '222-368'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9ce28911-5103-4e74-8aee-bd31559ffc8b'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-01-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80004' and oi.sequential = '10' and oi.material = '222-368'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '20', '222-385', 'PULSE AUDIO CAIXA DE SOM BLUETOOTH PORTÁTIL RESISTENTE À ÁGUA - ITEM 2', 'GM9-000010', 'SUP-540099', 'B08RLHGBWT', 1, 'EA', 54.89, 11.83, 11.83
from public.orders where purchase_order = 'AKDN-80004'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-01-09'::date, '113-1000148-2000279', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-01-28'::date, 'FedEx Demo', 'DEMO00000502', '2026-01-18'::date, 'RCPT-073009', '2026-01-28'::date, '2026-01-20'::date, 'NX-041009-26',
  '2026-01-30'::date, '2026-01-31'::date, '2026-02-01'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80004' and oi.sequential = '20' and oi.material = '222-385'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5856193f-c862-40b8-b0d5-4a5f1343c187'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-02-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80004' and oi.sequential = '20' and oi.material = '222-385'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '250c1cc1-65ba-4a7d-a4e5-81dbf4d447e8'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-01-31'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80004' and oi.sequential = '20' and oi.material = '222-385'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b37b6321-27b0-4b90-a41c-0e8c14cad863'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-01-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80004' and oi.sequential = '20' and oi.material = '222-385'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '579754b8-2d3c-47a9-9054-92a7e2e5c226'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-01-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80004' and oi.sequential = '20' and oi.material = '222-385'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '6767e053-09b4-4cab-8f19-b52471232ad4'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-01-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80004' and oi.sequential = '20' and oi.material = '222-385'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '222-402', 'CLOUD REST TRAVESSEIRO VISCOELÁSTICO ORTOPÉDICO COM CAPA LAVÁVEL - ITEM 1', 'GM9-000011', 'SUP-540110', 'B09R9RYPB2', 2, 'EA', 116.14, 12.2, 24.4
from public.orders where purchase_order = 'AKDN-80005'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-01-11'::date, '113-1000185-2000310', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-01-26'::date, 'Global Parcel Demo', 'DEMO00000601', '2026-01-19'::date, 'RCPT-073010', '2026-01-26'::date, '2026-01-22'::date, 'NX-041010-26',
  '2026-01-29'::date, '2026-01-31'::date, '2026-02-02'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80005' and oi.sequential = '10' and oi.material = '222-402'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0d64e36d-6444-4fc7-85a6-9fde3bf738b1'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-02-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80005' and oi.sequential = '10' and oi.material = '222-402'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '490dc43c-cead-4c8d-9e07-e4268a3a404d'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-01-31'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80005' and oi.sequential = '10' and oi.material = '222-402'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2372d3c3-279e-422a-b575-d6791c526b12'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-01-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80005' and oi.sequential = '10' and oi.material = '222-402'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4d1c71f9-6b53-4674-b236-a495dbd7be91'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-01-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80005' and oi.sequential = '10' and oi.material = '222-402'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9b436e3f-1c58-4a15-99eb-0d3896641dc5'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-01-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80005' and oi.sequential = '10' and oi.material = '222-402'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '20', '222-419', 'LUMINA HOME LUMINÁRIA DE MESA LED ARTICULADA COM CONTROLE DE INTENSIDADE - ITEM 2', 'GM9-000012', 'SUP-540121', 'B0AQVYG2Q9', 1, 'EA', 61.34, 12.57, 12.57
from public.orders where purchase_order = 'AKDN-80005'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-01-11'::date, '113-1000185-2000341', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-01-27'::date, 'Global Parcel Demo', 'DEMO00000602', '2026-01-20'::date, 'RCPT-073011', '2026-01-27'::date, '2026-01-23'::date, 'NX-041011-26',
  '2026-01-30'::date, '2026-02-01'::date, '2026-02-03'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80005' and oi.sequential = '20' and oi.material = '222-419'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f9584d14-f9c8-40c4-8fb2-51f2ffbcda3b'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-02-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80005' and oi.sequential = '20' and oi.material = '222-419'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '338f2615-abf1-4dd3-bf27-06c5b5346c66'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-02-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80005' and oi.sequential = '20' and oi.material = '222-419'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

commit;
