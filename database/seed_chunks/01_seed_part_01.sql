-- Demo seed part 01 of 10. Run files in numeric order.
begin;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80000', '900000000', 'Ana Clara Almeida Campos', '2026-01-05'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-01-06'::timestamptz, '2026-01-05T09:00:00.000Z'::timestamptz, '2026-01-06T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80001', '900000029', 'Bruno Almeida Campos', '2026-01-05'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo customer', '2026-01-07'::timestamptz, '2026-01-05T09:00:00.000Z'::timestamptz, '2026-01-07T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80002', '900000058', 'Camila Almeida Campos', '2026-01-06'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-01-09'::timestamptz, '2026-01-06T09:00:00.000Z'::timestamptz, '2026-01-09T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80003', '900000087', 'Daniel Almeida Campos', '2026-01-07'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-01-07'::timestamptz, null, null::timestamptz, '2026-01-07T09:00:00.000Z'::timestamptz, '2026-01-30T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80004', '900000116', 'Elisa Almeida Campos', '2026-01-08'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-01-09'::timestamptz, null, null::timestamptz, '2026-01-08T09:00:00.000Z'::timestamptz, '2026-01-31T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80005', '900000145', 'Felipe Almeida Campos', '2026-01-09'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-01-11'::timestamptz, null, null::timestamptz, '2026-01-09T09:00:00.000Z'::timestamptz, '2026-02-02T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80006', '900000174', 'Gabriela Almeida Campos', '2026-01-10'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-01-10'::timestamptz, null, null::timestamptz, '2026-01-10T09:00:00.000Z'::timestamptz, '2026-02-01T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80007', '900000203', 'Heitor Almeida Campos', '2026-01-10'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-01-11'::timestamptz, null, null::timestamptz, '2026-01-10T09:00:00.000Z'::timestamptz, '2026-01-31T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80008', '900000232', 'Isadora Almeida Campos', '2026-01-11'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-01-13'::timestamptz, null, null::timestamptz, '2026-01-11T09:00:00.000Z'::timestamptz, '2026-02-01T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80009', '900000261', 'João Miguel Almeida Campos', '2026-01-12'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-01-12'::timestamptz, null, null::timestamptz, '2026-01-12T09:00:00.000Z'::timestamptz, '2026-02-02T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80010', '900000290', 'Larissa Almeida Campos', '2026-01-13'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-01-14'::timestamptz, null, null::timestamptz, '2026-01-13T09:00:00.000Z'::timestamptz, '2026-02-02T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80011', '900000319', 'Mateus Almeida Campos', '2026-01-14'::date, 'Target', 'USA', 'Shipped', null,
  25, true, '2026-01-16'::timestamptz, null, null::timestamptz, '2026-01-14T09:00:00.000Z'::timestamptz, '2026-01-31T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80012', '900000348', 'Natália Almeida Campos', '2026-01-15'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-01-15'::timestamptz, null, null::timestamptz, '2026-01-15T09:00:00.000Z'::timestamptz, '2026-02-01T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80013', '900000377', 'Otávio Almeida Campos', '2026-01-16'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-01-17'::timestamptz, null, null::timestamptz, '2026-01-16T09:00:00.000Z'::timestamptz, '2026-02-05T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80014', '900000406', 'Paula Almeida Campos', '2026-01-16'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-01-18'::timestamptz, null, null::timestamptz, '2026-01-16T09:00:00.000Z'::timestamptz, '2026-02-01T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80015', '900000435', 'Rafael Almeida Campos', '2026-01-17'::date, 'Walmart', 'USA', 'Shipped', null,
  25, true, '2026-01-17'::timestamptz, null, null::timestamptz, '2026-01-17T09:00:00.000Z'::timestamptz, '2026-01-28T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80016', '900000464', 'Sofia Almeida Campos', '2026-01-18'::date, 'eBay', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-01-18T09:00:00.000Z'::timestamptz, '2026-01-18T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80017', '900000493', 'Tiago Almeida Campos', '2026-01-19'::date, 'Target', 'USA', 'Pending', null,
  25, true, '2026-01-21'::timestamptz, null, null::timestamptz, '2026-01-19T09:00:00.000Z'::timestamptz, '2026-01-21T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80018', '900000522', 'Vitória Almeida Campos', '2026-01-20'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-01-20'::timestamptz, null, null::timestamptz, '2026-01-20T09:00:00.000Z'::timestamptz, '2026-01-20T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80019', '900000551', 'William Almeida Campos', '2026-01-21'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-01-22'::timestamptz, null, null::timestamptz, '2026-01-21T09:00:00.000Z'::timestamptz, '2026-01-22T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80020', '900000580', 'Ana Clara Barbosa Lima', '2026-01-21'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-01-22'::timestamptz, '2026-01-21T09:00:00.000Z'::timestamptz, '2026-01-22T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80021', '900000609', 'Bruno Barbosa Lima', '2026-01-22'::date, 'Walmart', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo customer', '2026-01-24'::timestamptz, '2026-01-22T09:00:00.000Z'::timestamptz, '2026-01-24T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80022', '900000638', 'Camila Barbosa Lima', '2026-01-23'::date, 'eBay', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-01-26'::timestamptz, '2026-01-23T09:00:00.000Z'::timestamptz, '2026-01-26T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80023', '900000667', 'Daniel Barbosa Lima', '2026-01-24'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-01-26'::timestamptz, null, null::timestamptz, '2026-01-24T09:00:00.000Z'::timestamptz, '2026-02-19T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80024', '900000696', 'Elisa Barbosa Lima', '2026-01-25'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-01-25'::timestamptz, null, null::timestamptz, '2026-01-25T09:00:00.000Z'::timestamptz, '2026-02-14T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80025', '900000725', 'Felipe Barbosa Lima', '2026-01-26'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-01-27'::timestamptz, null, null::timestamptz, '2026-01-26T09:00:00.000Z'::timestamptz, '2026-02-16T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80026', '900000754', 'Gabriela Barbosa Lima', '2026-01-27'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-01-29'::timestamptz, null, null::timestamptz, '2026-01-27T09:00:00.000Z'::timestamptz, '2026-02-21T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80027', '900000783', 'Heitor Barbosa Lima', '2026-01-27'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-01-27'::timestamptz, null, null::timestamptz, '2026-01-27T09:00:00.000Z'::timestamptz, '2026-02-21T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80028', '900000812', 'Isadora Barbosa Lima', '2026-01-28'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-01-29'::timestamptz, null, null::timestamptz, '2026-01-28T09:00:00.000Z'::timestamptz, '2026-02-15T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80029', '900000841', 'João Miguel Barbosa Lima', '2026-01-29'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-01-31'::timestamptz, null, null::timestamptz, '2026-01-29T09:00:00.000Z'::timestamptz, '2026-02-22T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80030', '900000870', 'Larissa Barbosa Lima', '2026-01-30'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-01-30'::timestamptz, null, null::timestamptz, '2026-01-30T09:00:00.000Z'::timestamptz, '2026-02-16T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80031', '900000899', 'Mateus Barbosa Lima', '2026-01-31'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-02-01'::timestamptz, null, null::timestamptz, '2026-01-31T09:00:00.000Z'::timestamptz, '2026-02-15T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80032', '900000928', 'Natália Barbosa Lima', '2026-02-01'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-02-03'::timestamptz, null, null::timestamptz, '2026-02-01T09:00:00.000Z'::timestamptz, '2026-02-19T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80033', '900000957', 'Otávio Barbosa Lima', '2026-02-02'::date, 'Walmart', 'USA', 'Shipped', null,
  25, true, '2026-02-02'::timestamptz, null, null::timestamptz, '2026-02-02T09:00:00.000Z'::timestamptz, '2026-02-20T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80034', '900000986', 'Paula Barbosa Lima', '2026-02-02'::date, 'eBay', 'USA', 'Shipped', null,
  25, true, '2026-02-03'::timestamptz, null, null::timestamptz, '2026-02-02T09:00:00.000Z'::timestamptz, '2026-02-23T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80035', '900001015', 'Rafael Barbosa Lima', '2026-02-03'::date, 'Target', 'USA', 'Shipped', null,
  25, true, '2026-02-05'::timestamptz, null, null::timestamptz, '2026-02-03T09:00:00.000Z'::timestamptz, '2026-02-15T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80036', '900001044', 'Sofia Barbosa Lima', '2026-02-04'::date, 'Amazon', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-02-04T09:00:00.000Z'::timestamptz, '2026-02-04T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80037', '900001073', 'Tiago Barbosa Lima', '2026-02-05'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-02-06'::timestamptz, null, null::timestamptz, '2026-02-05T09:00:00.000Z'::timestamptz, '2026-02-06T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80038', '900001102', 'Vitória Barbosa Lima', '2026-02-06'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-02-08'::timestamptz, null, null::timestamptz, '2026-02-06T09:00:00.000Z'::timestamptz, '2026-02-08T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80039', '900001131', 'William Barbosa Lima', '2026-02-07'::date, 'Walmart', 'USA', 'Pending', null,
  25, true, '2026-02-07'::timestamptz, null, null::timestamptz, '2026-02-07T09:00:00.000Z'::timestamptz, '2026-02-07T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80040', '900001160', 'Ana Clara Cardoso Freitas', '2026-02-07'::date, 'eBay', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-02-08'::timestamptz, '2026-02-07T09:00:00.000Z'::timestamptz, '2026-02-08T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80041', '900001189', 'Bruno Cardoso Freitas', '2026-02-08'::date, 'Target', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo customer', '2026-02-10'::timestamptz, '2026-02-08T09:00:00.000Z'::timestamptz, '2026-02-10T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80042', '900001218', 'Camila Cardoso Freitas', '2026-02-09'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-02-12'::timestamptz, '2026-02-09T09:00:00.000Z'::timestamptz, '2026-02-12T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80043', '900001247', 'Daniel Cardoso Freitas', '2026-02-10'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-02-11'::timestamptz, null, null::timestamptz, '2026-02-10T09:00:00.000Z'::timestamptz, '2026-03-05T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80044', '900001276', 'Elisa Cardoso Freitas', '2026-02-11'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-02-13'::timestamptz, null, null::timestamptz, '2026-02-11T09:00:00.000Z'::timestamptz, '2026-03-06T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80045', '900001305', 'Felipe Cardoso Freitas', '2026-02-12'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-02-12'::timestamptz, null, null::timestamptz, '2026-02-12T09:00:00.000Z'::timestamptz, '2026-03-02T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80046', '900001334', 'Gabriela Cardoso Freitas', '2026-02-13'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-02-14'::timestamptz, null, null::timestamptz, '2026-02-13T09:00:00.000Z'::timestamptz, '2026-03-07T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80047', '900001363', 'Heitor Cardoso Freitas', '2026-02-13'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-02-15'::timestamptz, null, null::timestamptz, '2026-02-13T09:00:00.000Z'::timestamptz, '2026-03-13T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80048', '900001392', 'Isadora Cardoso Freitas', '2026-02-14'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-02-14'::timestamptz, null, null::timestamptz, '2026-02-14T09:00:00.000Z'::timestamptz, '2026-03-08T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80049', '900001421', 'João Miguel Cardoso Freitas', '2026-02-15'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-02-16'::timestamptz, null, null::timestamptz, '2026-02-15T09:00:00.000Z'::timestamptz, '2026-03-08T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80050', '900001450', 'Larissa Cardoso Freitas', '2026-02-16'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-02-18'::timestamptz, null, null::timestamptz, '2026-02-16T09:00:00.000Z'::timestamptz, '2026-03-08T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80051', '900001479', 'Mateus Cardoso Freitas', '2026-02-17'::date, 'Walmart', 'USA', 'Shipped', null,
  25, true, '2026-02-17'::timestamptz, null, null::timestamptz, '2026-02-17T09:00:00.000Z'::timestamptz, '2026-03-02T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80052', '900001508', 'Natália Cardoso Freitas', '2026-02-18'::date, 'eBay', 'USA', 'Shipped', null,
  25, true, '2026-02-19'::timestamptz, null, null::timestamptz, '2026-02-18T09:00:00.000Z'::timestamptz, '2026-03-06T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80053', '900001537', 'Otávio Cardoso Freitas', '2026-02-18'::date, 'Target', 'USA', 'Shipped', null,
  25, true, '2026-02-20'::timestamptz, null, null::timestamptz, '2026-02-18T09:00:00.000Z'::timestamptz, '2026-03-09T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80054', '900001566', 'Paula Cardoso Freitas', '2026-02-19'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-02-19'::timestamptz, null, null::timestamptz, '2026-02-19T09:00:00.000Z'::timestamptz, '2026-03-10T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80055', '900001595', 'Rafael Cardoso Freitas', '2026-02-20'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-02-21'::timestamptz, null, null::timestamptz, '2026-02-20T09:00:00.000Z'::timestamptz, '2026-03-09T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80056', '900001624', 'Sofia Cardoso Freitas', '2026-02-21'::date, 'Amazon', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-02-21T09:00:00.000Z'::timestamptz, '2026-02-21T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80057', '900001653', 'Tiago Cardoso Freitas', '2026-02-22'::date, 'Walmart', 'USA', 'Pending', null,
  25, true, '2026-02-22'::timestamptz, null, null::timestamptz, '2026-02-22T09:00:00.000Z'::timestamptz, '2026-02-22T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80058', '900001682', 'Vitória Cardoso Freitas', '2026-02-23'::date, 'eBay', 'USA', 'Pending', null,
  25, true, '2026-02-24'::timestamptz, null, null::timestamptz, '2026-02-23T09:00:00.000Z'::timestamptz, '2026-02-24T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80059', '900001711', 'William Cardoso Freitas', '2026-02-24'::date, 'Target', 'USA', 'Pending', null,
  25, true, '2026-02-26'::timestamptz, null, null::timestamptz, '2026-02-24T09:00:00.000Z'::timestamptz, '2026-02-26T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80060', '900001740', 'Ana Clara Duarte Nogueira', '2026-02-24'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-02-25'::timestamptz, '2026-02-24T09:00:00.000Z'::timestamptz, '2026-02-25T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80061', '900001769', 'Bruno Duarte Nogueira', '2026-02-25'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo customer', '2026-02-27'::timestamptz, '2026-02-25T09:00:00.000Z'::timestamptz, '2026-02-27T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80062', '900001798', 'Camila Duarte Nogueira', '2026-02-26'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-03-01'::timestamptz, '2026-02-26T09:00:00.000Z'::timestamptz, '2026-03-01T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80063', '900001827', 'Daniel Duarte Nogueira', '2026-02-27'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-02-27'::timestamptz, null, null::timestamptz, '2026-02-27T09:00:00.000Z'::timestamptz, '2026-03-19T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80064', '900001856', 'Elisa Duarte Nogueira', '2026-02-28'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-03-01'::timestamptz, null, null::timestamptz, '2026-02-28T09:00:00.000Z'::timestamptz, '2026-03-20T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80065', '900001885', 'Felipe Duarte Nogueira', '2026-03-01'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-03-03'::timestamptz, null, null::timestamptz, '2026-03-01T09:00:00.000Z'::timestamptz, '2026-03-22T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80066', '900001914', 'Gabriela Duarte Nogueira', '2026-03-02'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-03-02'::timestamptz, null, null::timestamptz, '2026-03-02T09:00:00.000Z'::timestamptz, '2026-03-21T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80067', '900001943', 'Heitor Duarte Nogueira', '2026-03-02'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-03-03'::timestamptz, null, null::timestamptz, '2026-03-02T09:00:00.000Z'::timestamptz, '2026-03-27T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80068', '900001972', 'Isadora Duarte Nogueira', '2026-03-03'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-03-05'::timestamptz, null, null::timestamptz, '2026-03-03T09:00:00.000Z'::timestamptz, '2026-03-28T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80069', '900002001', 'João Miguel Duarte Nogueira', '2026-03-04'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-03-04'::timestamptz, null, null::timestamptz, '2026-03-04T09:00:00.000Z'::timestamptz, '2026-03-29T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80070', '900002030', 'Larissa Duarte Nogueira', '2026-03-05'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-03-06'::timestamptz, null, null::timestamptz, '2026-03-05T09:00:00.000Z'::timestamptz, '2026-03-22T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80071', '900002059', 'Mateus Duarte Nogueira', '2026-03-06'::date, 'Target', 'USA', 'Shipped', null,
  25, true, '2026-03-08'::timestamptz, null, null::timestamptz, '2026-03-06T09:00:00.000Z'::timestamptz, '2026-03-20T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80072', '900002088', 'Natália Duarte Nogueira', '2026-03-07'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-03-07'::timestamptz, null, null::timestamptz, '2026-03-07T09:00:00.000Z'::timestamptz, '2026-03-21T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80073', '900002117', 'Otávio Duarte Nogueira', '2026-03-07'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-03-08'::timestamptz, null, null::timestamptz, '2026-03-07T09:00:00.000Z'::timestamptz, '2026-03-24T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80074', '900002146', 'Paula Duarte Nogueira', '2026-03-08'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-03-10'::timestamptz, null, null::timestamptz, '2026-03-08T09:00:00.000Z'::timestamptz, '2026-03-28T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80075', '900002175', 'Rafael Duarte Nogueira', '2026-03-09'::date, 'Walmart', 'USA', 'Shipped', null,
  25, true, '2026-03-09'::timestamptz, null, null::timestamptz, '2026-03-09T09:00:00.000Z'::timestamptz, '2026-03-24T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80076', '900002204', 'Sofia Duarte Nogueira', '2026-03-10'::date, 'eBay', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-03-10T09:00:00.000Z'::timestamptz, '2026-03-10T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80077', '900002233', 'Tiago Duarte Nogueira', '2026-03-11'::date, 'Target', 'USA', 'Pending', null,
  25, true, '2026-03-13'::timestamptz, null, null::timestamptz, '2026-03-11T09:00:00.000Z'::timestamptz, '2026-03-13T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80078', '900002262', 'Vitória Duarte Nogueira', '2026-03-12'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-03-12'::timestamptz, null, null::timestamptz, '2026-03-12T09:00:00.000Z'::timestamptz, '2026-03-12T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80079', '900002291', 'William Duarte Nogueira', '2026-03-13'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-03-14'::timestamptz, null, null::timestamptz, '2026-03-13T09:00:00.000Z'::timestamptz, '2026-03-14T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80080', '900002320', 'Ana Clara Esteves Moraes', '2026-03-13'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-03-14'::timestamptz, '2026-03-13T09:00:00.000Z'::timestamptz, '2026-03-14T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80081', '900002349', 'Bruno Esteves Moraes', '2026-03-14'::date, 'Walmart', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo customer', '2026-03-16'::timestamptz, '2026-03-14T09:00:00.000Z'::timestamptz, '2026-03-16T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80082', '900002378', 'Camila Esteves Moraes', '2026-03-15'::date, 'eBay', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-03-18'::timestamptz, '2026-03-15T09:00:00.000Z'::timestamptz, '2026-03-18T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80083', '900002407', 'Daniel Esteves Moraes', '2026-03-16'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-03-18'::timestamptz, null, null::timestamptz, '2026-03-16T09:00:00.000Z'::timestamptz, '2026-04-15T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80084', '900002436', 'Elisa Esteves Moraes', '2026-03-17'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-03-17'::timestamptz, null, null::timestamptz, '2026-03-17T09:00:00.000Z'::timestamptz, '2026-04-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80085', '900002465', 'Felipe Esteves Moraes', '2026-03-18'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-03-19'::timestamptz, null, null::timestamptz, '2026-03-18T09:00:00.000Z'::timestamptz, '2026-04-05T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80086', '900002494', 'Gabriela Esteves Moraes', '2026-03-18'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-03-20'::timestamptz, null, null::timestamptz, '2026-03-18T09:00:00.000Z'::timestamptz, '2026-04-09T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80087', '900002523', 'Heitor Esteves Moraes', '2026-03-19'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-03-19'::timestamptz, null, null::timestamptz, '2026-03-19T09:00:00.000Z'::timestamptz, '2026-04-10T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80088', '900002552', 'Isadora Esteves Moraes', '2026-03-20'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-03-21'::timestamptz, null, null::timestamptz, '2026-03-20T09:00:00.000Z'::timestamptz, '2026-04-11T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80089', '900002581', 'João Miguel Esteves Moraes', '2026-03-21'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-03-23'::timestamptz, null, null::timestamptz, '2026-03-21T09:00:00.000Z'::timestamptz, '2026-04-18T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80090', '900002610', 'Larissa Esteves Moraes', '2026-03-22'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-03-22'::timestamptz, null, null::timestamptz, '2026-03-22T09:00:00.000Z'::timestamptz, '2026-04-12T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80091', '900002639', 'Mateus Esteves Moraes', '2026-03-23'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-03-24'::timestamptz, null, null::timestamptz, '2026-03-23T09:00:00.000Z'::timestamptz, '2026-04-04T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80092', '900002668', 'Natália Esteves Moraes', '2026-03-24'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-03-26'::timestamptz, null, null::timestamptz, '2026-03-24T09:00:00.000Z'::timestamptz, '2026-04-08T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80093', '900002697', 'Otávio Esteves Moraes', '2026-03-24'::date, 'Walmart', 'USA', 'Shipped', null,
  25, true, '2026-03-24'::timestamptz, null, null::timestamptz, '2026-03-24T09:00:00.000Z'::timestamptz, '2026-04-08T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80094', '900002726', 'Paula Esteves Moraes', '2026-03-25'::date, 'eBay', 'USA', 'Shipped', null,
  25, true, '2026-03-26'::timestamptz, null, null::timestamptz, '2026-03-25T09:00:00.000Z'::timestamptz, '2026-04-12T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80095', '900002755', 'Rafael Esteves Moraes', '2026-03-26'::date, 'Target', 'USA', 'Shipped', null,
  25, true, '2026-03-28'::timestamptz, null, null::timestamptz, '2026-03-26T09:00:00.000Z'::timestamptz, '2026-04-11T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80096', '900002784', 'Sofia Esteves Moraes', '2026-03-27'::date, 'Amazon', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-03-27T09:00:00.000Z'::timestamptz, '2026-03-27T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80097', '900002813', 'Tiago Esteves Moraes', '2026-03-28'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-03-29'::timestamptz, null, null::timestamptz, '2026-03-28T09:00:00.000Z'::timestamptz, '2026-03-29T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80098', '900002842', 'Vitória Esteves Moraes', '2026-03-29'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-03-31'::timestamptz, null, null::timestamptz, '2026-03-29T09:00:00.000Z'::timestamptz, '2026-03-31T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80099', '900002871', 'William Esteves Moraes', '2026-03-30'::date, 'Walmart', 'USA', 'Pending', null,
  25, true, '2026-03-30'::timestamptz, null, null::timestamptz, '2026-03-30T09:00:00.000Z'::timestamptz, '2026-03-30T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80100', '900002900', 'Ana Clara Ferreira Prado', '2026-03-30'::date, 'eBay', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-03-31'::timestamptz, '2026-03-30T09:00:00.000Z'::timestamptz, '2026-03-31T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80101', '900002929', 'Bruno Ferreira Prado', '2026-03-31'::date, 'Target', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo customer', '2026-04-02'::timestamptz, '2026-03-31T09:00:00.000Z'::timestamptz, '2026-04-02T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80102', '900002958', 'Camila Ferreira Prado', '2026-04-01'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-04-04'::timestamptz, '2026-04-01T09:00:00.000Z'::timestamptz, '2026-04-04T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80103', '900002987', 'Daniel Ferreira Prado', '2026-04-02'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-04-03'::timestamptz, null, null::timestamptz, '2026-04-02T09:00:00.000Z'::timestamptz, '2026-04-29T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80104', '900003016', 'Elisa Ferreira Prado', '2026-04-03'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-04-05'::timestamptz, null, null::timestamptz, '2026-04-03T09:00:00.000Z'::timestamptz, '2026-04-30T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80105', '900003045', 'Felipe Ferreira Prado', '2026-04-04'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-04-04'::timestamptz, null, null::timestamptz, '2026-04-04T09:00:00.000Z'::timestamptz, '2026-04-19T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80106', '900003074', 'Gabriela Ferreira Prado', '2026-04-04'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-04-05'::timestamptz, null, null::timestamptz, '2026-04-04T09:00:00.000Z'::timestamptz, '2026-04-23T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80107', '900003103', 'Heitor Ferreira Prado', '2026-04-05'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-04-07'::timestamptz, null, null::timestamptz, '2026-04-05T09:00:00.000Z'::timestamptz, '2026-04-30T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80108', '900003132', 'Isadora Ferreira Prado', '2026-04-06'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-04-06'::timestamptz, null, null::timestamptz, '2026-04-06T09:00:00.000Z'::timestamptz, '2026-04-25T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80109', '900003161', 'João Miguel Ferreira Prado', '2026-04-07'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-04-08'::timestamptz, null, null::timestamptz, '2026-04-07T09:00:00.000Z'::timestamptz, '2026-05-02T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80110', '900003190', 'Larissa Ferreira Prado', '2026-04-08'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-04-10'::timestamptz, null, null::timestamptz, '2026-04-08T09:00:00.000Z'::timestamptz, '2026-05-02T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80111', '900003219', 'Mateus Ferreira Prado', '2026-04-09'::date, 'Walmart', 'USA', 'Shipped', null,
  25, true, '2026-04-09'::timestamptz, null, null::timestamptz, '2026-04-09T09:00:00.000Z'::timestamptz, '2026-04-26T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80112', '900003248', 'Natália Ferreira Prado', '2026-04-10'::date, 'eBay', 'USA', 'Shipped', null,
  25, true, '2026-04-11'::timestamptz, null, null::timestamptz, '2026-04-10T09:00:00.000Z'::timestamptz, '2026-04-23T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80113', '900003277', 'Otávio Ferreira Prado', '2026-04-10'::date, 'Target', 'USA', 'Shipped', null,
  25, true, '2026-04-12'::timestamptz, null, null::timestamptz, '2026-04-10T09:00:00.000Z'::timestamptz, '2026-04-26T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80114', '900003306', 'Paula Ferreira Prado', '2026-04-11'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-04-11'::timestamptz, null, null::timestamptz, '2026-04-11T09:00:00.000Z'::timestamptz, '2026-04-27T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80115', '900003335', 'Rafael Ferreira Prado', '2026-04-12'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-04-13'::timestamptz, null, null::timestamptz, '2026-04-12T09:00:00.000Z'::timestamptz, '2026-04-26T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80116', '900003364', 'Sofia Ferreira Prado', '2026-04-13'::date, 'Amazon', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-04-13T09:00:00.000Z'::timestamptz, '2026-04-13T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80117', '900003393', 'Tiago Ferreira Prado', '2026-04-14'::date, 'Walmart', 'USA', 'Pending', null,
  25, true, '2026-04-14'::timestamptz, null, null::timestamptz, '2026-04-14T09:00:00.000Z'::timestamptz, '2026-04-14T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80118', '900003422', 'Vitória Ferreira Prado', '2026-04-15'::date, 'eBay', 'USA', 'Pending', null,
  25, true, '2026-04-16'::timestamptz, null, null::timestamptz, '2026-04-15T09:00:00.000Z'::timestamptz, '2026-04-16T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80119', '900003451', 'William Ferreira Prado', '2026-04-15'::date, 'Target', 'USA', 'Pending', null,
  25, true, '2026-04-17'::timestamptz, null, null::timestamptz, '2026-04-15T09:00:00.000Z'::timestamptz, '2026-04-17T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80120', '900003480', 'Ana Clara Gomes Tavares', '2026-04-16'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-04-17'::timestamptz, '2026-04-16T09:00:00.000Z'::timestamptz, '2026-04-17T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80121', '900003509', 'Bruno Gomes Tavares', '2026-04-17'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo customer', '2026-04-19'::timestamptz, '2026-04-17T09:00:00.000Z'::timestamptz, '2026-04-19T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80122', '900003538', 'Camila Gomes Tavares', '2026-04-18'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-04-21'::timestamptz, '2026-04-18T09:00:00.000Z'::timestamptz, '2026-04-21T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80123', '900003567', 'Daniel Gomes Tavares', '2026-04-19'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-04-19'::timestamptz, null, null::timestamptz, '2026-04-19T09:00:00.000Z'::timestamptz, '2026-05-13T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80124', '900003596', 'Elisa Gomes Tavares', '2026-04-20'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-04-21'::timestamptz, null, null::timestamptz, '2026-04-20T09:00:00.000Z'::timestamptz, '2026-05-14T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80125', '900003625', 'Felipe Gomes Tavares', '2026-04-21'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-04-23'::timestamptz, null, null::timestamptz, '2026-04-21T09:00:00.000Z'::timestamptz, '2026-05-16T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80126', '900003654', 'Gabriela Gomes Tavares', '2026-04-21'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-04-21'::timestamptz, null, null::timestamptz, '2026-04-21T09:00:00.000Z'::timestamptz, '2026-05-07T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80127', '900003683', 'Heitor Gomes Tavares', '2026-04-22'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-04-23'::timestamptz, null, null::timestamptz, '2026-04-22T09:00:00.000Z'::timestamptz, '2026-05-14T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80128', '900003712', 'Isadora Gomes Tavares', '2026-04-23'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-04-25'::timestamptz, null, null::timestamptz, '2026-04-23T09:00:00.000Z'::timestamptz, '2026-05-15T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80129', '900003741', 'João Miguel Gomes Tavares', '2026-04-24'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-04-24'::timestamptz, null, null::timestamptz, '2026-04-24T09:00:00.000Z'::timestamptz, '2026-05-16T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80130', '900003770', 'Larissa Gomes Tavares', '2026-04-25'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-04-26'::timestamptz, null, null::timestamptz, '2026-04-25T09:00:00.000Z'::timestamptz, '2026-05-16T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80131', '900003799', 'Mateus Gomes Tavares', '2026-04-26'::date, 'Target', 'USA', 'Shipped', null,
  25, true, '2026-04-28'::timestamptz, null, null::timestamptz, '2026-04-26T09:00:00.000Z'::timestamptz, '2026-05-14T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80132', '900003828', 'Natália Gomes Tavares', '2026-04-27'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-04-27'::timestamptz, null, null::timestamptz, '2026-04-27T09:00:00.000Z'::timestamptz, '2026-05-15T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80133', '900003857', 'Otávio Gomes Tavares', '2026-04-27'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-04-28'::timestamptz, null, null::timestamptz, '2026-04-27T09:00:00.000Z'::timestamptz, '2026-05-11T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80134', '900003886', 'Paula Gomes Tavares', '2026-04-28'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-04-30'::timestamptz, null, null::timestamptz, '2026-04-28T09:00:00.000Z'::timestamptz, '2026-05-15T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80135', '900003915', 'Rafael Gomes Tavares', '2026-04-29'::date, 'Walmart', 'USA', 'Shipped', null,
  25, true, '2026-04-29'::timestamptz, null, null::timestamptz, '2026-04-29T09:00:00.000Z'::timestamptz, '2026-05-11T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80136', '900003944', 'Sofia Gomes Tavares', '2026-04-30'::date, 'eBay', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-04-30T09:00:00.000Z'::timestamptz, '2026-04-30T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80137', '900003973', 'Tiago Gomes Tavares', '2026-05-01'::date, 'Target', 'USA', 'Pending', null,
  25, true, '2026-05-03'::timestamptz, null, null::timestamptz, '2026-05-01T09:00:00.000Z'::timestamptz, '2026-05-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80138', '900004002', 'Vitória Gomes Tavares', '2026-05-02'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-05-02'::timestamptz, null, null::timestamptz, '2026-05-02T09:00:00.000Z'::timestamptz, '2026-05-02T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80139', '900004031', 'William Gomes Tavares', '2026-05-02'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-05-03'::timestamptz, null, null::timestamptz, '2026-05-02T09:00:00.000Z'::timestamptz, '2026-05-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80140', '900004060', 'Ana Clara Henrique Moreira', '2026-05-03'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-05-04'::timestamptz, '2026-05-03T09:00:00.000Z'::timestamptz, '2026-05-04T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80141', '900004089', 'Bruno Henrique Moreira', '2026-05-04'::date, 'Walmart', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo customer', '2026-05-06'::timestamptz, '2026-05-04T09:00:00.000Z'::timestamptz, '2026-05-06T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80142', '900004118', 'Camila Henrique Moreira', '2026-05-05'::date, 'eBay', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-05-08'::timestamptz, '2026-05-05T09:00:00.000Z'::timestamptz, '2026-05-08T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80143', '900004147', 'Daniel Henrique Moreira', '2026-05-06'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-05-08'::timestamptz, null, null::timestamptz, '2026-05-06T09:00:00.000Z'::timestamptz, '2026-06-02T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80144', '900004176', 'Elisa Henrique Moreira', '2026-05-07'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-05-07'::timestamptz, null, null::timestamptz, '2026-05-07T09:00:00.000Z'::timestamptz, '2026-05-28T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80145', '900004205', 'Felipe Henrique Moreira', '2026-05-08'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-05-09'::timestamptz, null, null::timestamptz, '2026-05-08T09:00:00.000Z'::timestamptz, '2026-05-30T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80146', '900004234', 'Gabriela Henrique Moreira', '2026-05-08'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-05-10'::timestamptz, null, null::timestamptz, '2026-05-08T09:00:00.000Z'::timestamptz, '2026-06-03T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80147', '900004263', 'Heitor Henrique Moreira', '2026-05-09'::date, 'Walmart', 'USA', 'Delivered', null,
  25, true, '2026-05-09'::timestamptz, null, null::timestamptz, '2026-05-09T09:00:00.000Z'::timestamptz, '2026-05-28T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80148', '900004292', 'Isadora Henrique Moreira', '2026-05-10'::date, 'eBay', 'USA', 'Delivered', null,
  25, true, '2026-05-11'::timestamptz, null, null::timestamptz, '2026-05-10T09:00:00.000Z'::timestamptz, '2026-05-29T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80149', '900004321', 'João Miguel Henrique Moreira', '2026-05-11'::date, 'Target', 'USA', 'Delivered', null,
  25, true, '2026-05-13'::timestamptz, null, null::timestamptz, '2026-05-11T09:00:00.000Z'::timestamptz, '2026-06-05T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80150', '900004350', 'Larissa Henrique Moreira', '2026-05-12'::date, 'Amazon', 'USA', 'Delivered', null,
  25, true, '2026-05-12'::timestamptz, null, null::timestamptz, '2026-05-12T09:00:00.000Z'::timestamptz, '2026-05-30T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80151', '900004379', 'Mateus Henrique Moreira', '2026-05-13'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-05-14'::timestamptz, null, null::timestamptz, '2026-05-13T09:00:00.000Z'::timestamptz, '2026-05-29T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80152', '900004408', 'Natália Henrique Moreira', '2026-05-13'::date, 'Amazon', 'USA', 'Shipped', null,
  25, true, '2026-05-15'::timestamptz, null, null::timestamptz, '2026-05-13T09:00:00.000Z'::timestamptz, '2026-06-01T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80153', '900004437', 'Otávio Henrique Moreira', '2026-05-14'::date, 'Walmart', 'USA', 'Shipped', null,
  25, true, '2026-05-14'::timestamptz, null, null::timestamptz, '2026-05-14T09:00:00.000Z'::timestamptz, '2026-06-02T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80154', '900004466', 'Paula Henrique Moreira', '2026-05-15'::date, 'eBay', 'USA', 'Shipped', null,
  25, true, '2026-05-16'::timestamptz, null, null::timestamptz, '2026-05-15T09:00:00.000Z'::timestamptz, '2026-05-30T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80155', '900004495', 'Rafael Henrique Moreira', '2026-05-16'::date, 'Target', 'USA', 'Shipped', null,
  25, true, '2026-05-18'::timestamptz, null, null::timestamptz, '2026-05-16T09:00:00.000Z'::timestamptz, '2026-05-29T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80156', '900004524', 'Sofia Henrique Moreira', '2026-05-17'::date, 'Amazon', 'USA', 'Pending', null,
  25, false, null::timestamptz, null, null::timestamptz, '2026-05-17T09:00:00.000Z'::timestamptz, '2026-05-17T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80157', '900004553', 'Tiago Henrique Moreira', '2026-05-18'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-05-19'::timestamptz, null, null::timestamptz, '2026-05-18T09:00:00.000Z'::timestamptz, '2026-05-19T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80158', '900004582', 'Vitória Henrique Moreira', '2026-05-19'::date, 'Amazon', 'USA', 'Pending', null,
  25, true, '2026-05-21'::timestamptz, null, null::timestamptz, '2026-05-19T09:00:00.000Z'::timestamptz, '2026-05-21T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80159', '900004611', 'William Henrique Moreira', '2026-05-19'::date, 'Walmart', 'USA', 'Pending', null,
  25, true, '2026-05-19'::timestamptz, null, null::timestamptz, '2026-05-19T09:00:00.000Z'::timestamptz, '2026-05-19T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80160', '900004640', 'Ana Clara Ibrahim Costa', '2026-05-20'::date, 'eBay', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-05-21'::timestamptz, '2026-05-20T09:00:00.000Z'::timestamptz, '2026-05-21T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80161', '900004669', 'Bruno Ibrahim Costa', '2026-05-21'::date, 'Target', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo customer', '2026-05-23'::timestamptz, '2026-05-21T09:00:00.000Z'::timestamptz, '2026-05-23T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

insert into public.orders (
  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,
  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at
) values (
  'AKDN-80162', '900004698', 'Camila Ibrahim Costa', '2026-05-22'::date, 'Amazon', 'USA', 'Cancelled', 'Synthetic cancellation record',
  25, false, null::timestamptz, 'Cancelled by demo store', '2026-05-25'::timestamptz, '2026-05-22T09:00:00.000Z'::timestamptz, '2026-05-25T15:30:00.000Z'::timestamptz
) on conflict (purchase_order) do update set
  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,
  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,
  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,
  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;

commit;
