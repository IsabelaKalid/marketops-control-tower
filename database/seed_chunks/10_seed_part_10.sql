-- Demo seed part 10 of 10. Run files in numeric order.
begin;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'b9583eab-6311-4e30-b979-8323d12ddcb2'::uuid, id, true, 'Lucas Monteiro', '2026-05-18'::timestamptz from public.orders where purchase_order = 'AKDN-80155'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'da9f89f1-2608-4fa9-94f8-5bdf8765dc18'::uuid, id, true, 'Caio Nunes', '2026-05-19'::timestamptz from public.orders where purchase_order = 'AKDN-80157'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'fc7fbfa2-5acd-42d2-9f7a-6284d5bd475b'::uuid, id, true, 'Renata Alves', '2026-05-21'::timestamptz from public.orders where purchase_order = 'AKDN-80158'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '4ffdb447-df97-44c6-bdb3-310f2bf49033'::uuid, id, true, 'Lucas Monteiro', '2026-05-19'::timestamptz from public.orders where purchase_order = 'AKDN-80159'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select 'fe19fe1c-b134-4152-a04c-dd7f2aa47081'::uuid, id, 'Cancelled by demo store', 'seed', 'Marina Torres', '2026-05-21'::timestamptz from public.orders where purchase_order = 'AKDN-80160'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '9126b255-723c-443e-898e-27af855af260'::uuid, id, 'Cancelled by demo customer', 'seed', 'Caio Nunes', '2026-05-23'::timestamptz from public.orders where purchase_order = 'AKDN-80161'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '35440a3e-bad5-4ea0-bd9a-2c9f4f8a23ff'::uuid, id, 'Cancelled by demo store', 'seed', 'Renata Alves', '2026-05-25'::timestamptz from public.orders where purchase_order = 'AKDN-80162'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '5625ba4e-18c1-462c-9f50-fe88d9455cdc'::uuid, id, true, 'Lucas Monteiro', '2026-05-24'::timestamptz from public.orders where purchase_order = 'AKDN-80163'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'bc47e3ce-abcb-4da0-b3ee-4e7620e9e5e0'::uuid, id, true, 'Marina Torres', '2026-05-26'::timestamptz from public.orders where purchase_order = 'AKDN-80164'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'b2dc2fba-77bf-461c-b5fa-c5c26a8035ca'::uuid, id, true, 'Caio Nunes', '2026-05-25'::timestamptz from public.orders where purchase_order = 'AKDN-80165'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'bdb0576e-8881-44f3-a5d7-542de83f94c9'::uuid, id, true, 'Renata Alves', '2026-05-26'::timestamptz from public.orders where purchase_order = 'AKDN-80166'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '736bb7f9-0b89-40a7-b9cc-d3c272500847'::uuid, id, true, 'Lucas Monteiro', '2026-05-28'::timestamptz from public.orders where purchase_order = 'AKDN-80167'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'b2bb751b-ed99-46a0-a69a-e470060b462c'::uuid, id, true, 'Marina Torres', '2026-05-27'::timestamptz from public.orders where purchase_order = 'AKDN-80168'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '8f793ad5-19b6-4eb1-833c-cc9cbfffd489'::uuid, id, true, 'Caio Nunes', '2026-05-29'::timestamptz from public.orders where purchase_order = 'AKDN-80169'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '29d542a7-3afa-406f-8f1e-d3a05c1f7ec6'::uuid, id, true, 'Renata Alves', '2026-05-31'::timestamptz from public.orders where purchase_order = 'AKDN-80170'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f8316f4e-d8c5-4366-9ff6-cb2596fd535e'::uuid, id, true, 'Lucas Monteiro', '2026-05-30'::timestamptz from public.orders where purchase_order = 'AKDN-80171'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f4aae728-16de-41e1-98a5-6b95597f4efc'::uuid, id, true, 'Marina Torres', '2026-05-31'::timestamptz from public.orders where purchase_order = 'AKDN-80172'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'ad4e9bd7-a9a9-4a9c-9655-4a96de6604f9'::uuid, id, true, 'Caio Nunes', '2026-06-02'::timestamptz from public.orders where purchase_order = 'AKDN-80173'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '86796a58-d761-47c7-b27a-a11de8e3a0f1'::uuid, id, true, 'Renata Alves', '2026-06-01'::timestamptz from public.orders where purchase_order = 'AKDN-80174'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '7348a199-b746-42b3-ada0-c0056ffe4c5e'::uuid, id, true, 'Lucas Monteiro', '2026-06-03'::timestamptz from public.orders where purchase_order = 'AKDN-80175'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '86087427-765d-4190-b4f1-223e1023fde8'::uuid, id, true, 'Caio Nunes', '2026-06-04'::timestamptz from public.orders where purchase_order = 'AKDN-80177'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '74d9ea5d-74d5-45de-9bb6-2e71b8233a03'::uuid, id, true, 'Renata Alves', '2026-06-06'::timestamptz from public.orders where purchase_order = 'AKDN-80178'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '96d35f9c-b056-4b41-9e4b-a3beb4ec9d67'::uuid, id, true, 'Lucas Monteiro', '2026-06-07'::timestamptz from public.orders where purchase_order = 'AKDN-80179'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '3729d366-5caf-4cfa-b3c6-4efeb48c3111'::uuid, id, 'Cancelled by demo store', 'seed', 'Marina Torres', '2026-06-07'::timestamptz from public.orders where purchase_order = 'AKDN-80180'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '60dc1f84-16ea-4e8c-bf3e-40dfc37a09d5'::uuid, id, 'Cancelled by demo customer', 'seed', 'Caio Nunes', '2026-06-09'::timestamptz from public.orders where purchase_order = 'AKDN-80181'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '995a309b-6974-4007-8b43-66df7eb8f004'::uuid, id, 'Cancelled by demo store', 'seed', 'Renata Alves', '2026-06-11'::timestamptz from public.orders where purchase_order = 'AKDN-80182'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'a6bc7655-2bd2-4aeb-a0e2-4ff5786239af'::uuid, id, true, 'Lucas Monteiro', '2026-06-09'::timestamptz from public.orders where purchase_order = 'AKDN-80183'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'd23271f8-8302-4cb4-93fa-cb2a15712131'::uuid, id, true, 'Marina Torres', '2026-06-11'::timestamptz from public.orders where purchase_order = 'AKDN-80184'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f91feac5-026f-4f61-8c02-fb7ec4c3852a'::uuid, id, true, 'Caio Nunes', '2026-06-12'::timestamptz from public.orders where purchase_order = 'AKDN-80185'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '521d3cc7-e3ae-45f2-8543-235906bfce51'::uuid, id, true, 'Renata Alves', '2026-06-11'::timestamptz from public.orders where purchase_order = 'AKDN-80186'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '10962064-e604-48bd-96bb-5cb636f44c3d'::uuid, id, true, 'Lucas Monteiro', '2026-06-13'::timestamptz from public.orders where purchase_order = 'AKDN-80187'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '0cb70eaf-e241-47d3-af16-7f96d60b0f6f'::uuid, id, true, 'Marina Torres', '2026-06-15'::timestamptz from public.orders where purchase_order = 'AKDN-80188'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '1c8f6354-9536-4f67-9266-782b41072691'::uuid, id, true, 'Caio Nunes', '2026-06-14'::timestamptz from public.orders where purchase_order = 'AKDN-80189'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'eed676f9-9dad-46f0-95ab-43900e2b19a9'::uuid, id, true, 'Renata Alves', '2026-06-16'::timestamptz from public.orders where purchase_order = 'AKDN-80190'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '85b39c48-bd2a-44ba-b41f-2d1b1e72af3a'::uuid, id, true, 'Lucas Monteiro', '2026-06-18'::timestamptz from public.orders where purchase_order = 'AKDN-80191'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '993dd233-f4f2-4da5-bd34-d71c9ef0b9ff'::uuid, id, true, 'Marina Torres', '2026-06-16'::timestamptz from public.orders where purchase_order = 'AKDN-80192'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '546c26d3-d1e5-4f98-a668-3fb2b16adfff'::uuid, id, true, 'Caio Nunes', '2026-06-18'::timestamptz from public.orders where purchase_order = 'AKDN-80193'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '40e3b322-b508-4da8-b13d-793df256baf3'::uuid, id, true, 'Renata Alves', '2026-06-20'::timestamptz from public.orders where purchase_order = 'AKDN-80194'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '1f3674e4-1840-4299-bbfc-c345e6aba85c'::uuid, id, true, 'Lucas Monteiro', '2026-06-19'::timestamptz from public.orders where purchase_order = 'AKDN-80195'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '940c34e5-6e92-4d56-98dd-f905aee360c6'::uuid, id, true, 'Caio Nunes', '2026-06-23'::timestamptz from public.orders where purchase_order = 'AKDN-80197'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '615ee5c2-3d02-4953-89bd-d241281e4856'::uuid, id, true, 'Renata Alves', '2026-06-22'::timestamptz from public.orders where purchase_order = 'AKDN-80198'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '0acca8f2-f789-4b82-b5dd-26a228c73d5a'::uuid, id, true, 'Lucas Monteiro', '2026-06-23'::timestamptz from public.orders where purchase_order = 'AKDN-80199'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '2ee1ce42-3024-42f3-be95-ec34518200c0'::uuid, id, 'Cancelled by demo store', 'seed', 'Marina Torres', '2026-06-24'::timestamptz from public.orders where purchase_order = 'AKDN-80200'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '23862f9e-98a8-40c1-8d2c-0301e3ad65e6'::uuid, id, 'Cancelled by demo customer', 'seed', 'Caio Nunes', '2026-06-26'::timestamptz from public.orders where purchase_order = 'AKDN-80201'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '277d41d4-cdcf-425a-9b6d-ffac97d20d58'::uuid, id, 'Cancelled by demo store', 'seed', 'Renata Alves', '2026-06-28'::timestamptz from public.orders where purchase_order = 'AKDN-80202'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '3f039448-9979-4b02-b88a-1c70b3c22dc9'::uuid, id, true, 'Lucas Monteiro', '2026-06-28'::timestamptz from public.orders where purchase_order = 'AKDN-80203'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'b1f96b62-3221-4721-9c15-a2d0cf034a99'::uuid, id, true, 'Marina Torres', '2026-06-27'::timestamptz from public.orders where purchase_order = 'AKDN-80204'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '1a9b6faa-1290-4710-8ace-ca33df7ef278'::uuid, id, true, 'Caio Nunes', '2026-06-28'::timestamptz from public.orders where purchase_order = 'AKDN-80205'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '030c01ad-4cf6-443e-bd7f-01d0b7e1d4c5'::uuid, id, true, 'Renata Alves', '2026-06-30'::timestamptz from public.orders where purchase_order = 'AKDN-80206'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '81e0cc97-2c7b-4c10-b7e4-946970bb1b58'::uuid, id, true, 'Lucas Monteiro', '2026-06-29'::timestamptz from public.orders where purchase_order = 'AKDN-80207'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f919dad3-db5c-4415-a8f8-10a07dc1b3be'::uuid, id, true, 'Marina Torres', '2026-07-01'::timestamptz from public.orders where purchase_order = 'AKDN-80208'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '633e93fd-3037-4c50-9554-f7711024c534'::uuid, id, true, 'Caio Nunes', '2026-07-03'::timestamptz from public.orders where purchase_order = 'AKDN-80209'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '6cf03b08-c536-4151-850e-e5e37decc713'::uuid, id, true, 'Renata Alves', '2026-07-02'::timestamptz from public.orders where purchase_order = 'AKDN-80210'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f39a29b1-4628-49d6-8fbd-d3d4e09f35fb'::uuid, id, true, 'Lucas Monteiro', '2026-07-04'::timestamptz from public.orders where purchase_order = 'AKDN-80211'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '773b4f8f-fbc3-4013-b152-e343f23d060d'::uuid, id, true, 'Marina Torres', '2026-07-05'::timestamptz from public.orders where purchase_order = 'AKDN-80212'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '2027e39d-d623-44f0-ae11-6c24c12a9b63'::uuid, id, true, 'Caio Nunes', '2026-07-04'::timestamptz from public.orders where purchase_order = 'AKDN-80213'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'adb712b8-36bd-41f4-8460-9a17d48e7f73'::uuid, id, true, 'Renata Alves', '2026-07-06'::timestamptz from public.orders where purchase_order = 'AKDN-80214'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '8a05e05d-78b3-491d-885d-07966c2823ab'::uuid, id, true, 'Lucas Monteiro', '2026-07-08'::timestamptz from public.orders where purchase_order = 'AKDN-80215'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '5f133ee9-cbf5-4b6a-97ea-d372082c8296'::uuid, id, true, 'Caio Nunes', '2026-07-09'::timestamptz from public.orders where purchase_order = 'AKDN-80217'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '03c5d4e1-1c0e-4277-807c-36171d0f68a2'::uuid, id, true, 'Renata Alves', '2026-07-10'::timestamptz from public.orders where purchase_order = 'AKDN-80218'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'c594fdb1-fb50-4231-aba1-c3009cf0166d'::uuid, id, true, 'Lucas Monteiro', '2026-07-09'::timestamptz from public.orders where purchase_order = 'AKDN-80219'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '3333002b-8c5c-4cef-8ed0-c20976026c27'::uuid, id, 'Cancelled by demo store', 'seed', 'Marina Torres', '2026-07-11'::timestamptz from public.orders where purchase_order = 'AKDN-80220'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '6149ebe9-6ddb-4850-a709-2bf732ae3893'::uuid, id, 'Cancelled by demo customer', 'seed', 'Caio Nunes', '2026-07-13'::timestamptz from public.orders where purchase_order = 'AKDN-80221'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '4eb76998-4ff0-4f14-aa77-5719a0f12e9e'::uuid, id, 'Cancelled by demo store', 'seed', 'Renata Alves', '2026-07-15'::timestamptz from public.orders where purchase_order = 'AKDN-80222'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '06f3a364-646f-4d7c-9f72-da8896b176fa'::uuid, id, true, 'Lucas Monteiro', '2026-07-14'::timestamptz from public.orders where purchase_order = 'AKDN-80223'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'c58dbc90-e209-4151-be29-b5bb363ecf63'::uuid, id, true, 'Marina Torres', '2026-07-16'::timestamptz from public.orders where purchase_order = 'AKDN-80224'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'dc84032f-44bb-4eaf-9b69-b5578f2488c7'::uuid, id, true, 'Caio Nunes', '2026-07-14'::timestamptz from public.orders where purchase_order = 'AKDN-80225'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'fcbb970b-02a1-4b9e-b780-8f09099adaa6'::uuid, id, true, 'Renata Alves', '2026-07-16'::timestamptz from public.orders where purchase_order = 'AKDN-80226'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '6451ee2f-1ac9-4cbd-9bc0-e9c488072b3d'::uuid, id, true, 'Lucas Monteiro', '2026-07-18'::timestamptz from public.orders where purchase_order = 'AKDN-80227'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f04888bf-3d8c-400e-aaa7-da184f7697a5'::uuid, id, true, 'Marina Torres', '2026-07-17'::timestamptz from public.orders where purchase_order = 'AKDN-80228'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '432b8390-67e5-49ab-9ea2-02ab109ed696'::uuid, id, true, 'Caio Nunes', '2026-07-19'::timestamptz from public.orders where purchase_order = 'AKDN-80229'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '29c13da6-73e6-4255-a6db-4046c1d60578'::uuid, id, true, 'Renata Alves', '2026-07-21'::timestamptz from public.orders where purchase_order = 'AKDN-80230'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '3907e18f-ecc3-4b9a-ad87-d488f877ad7c'::uuid, id, true, 'Lucas Monteiro', '2026-07-20'::timestamptz from public.orders where purchase_order = 'AKDN-80231'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '7b576c1c-6838-4006-b7c8-ada53a63af8b'::uuid, id, true, 'Marina Torres', '2026-07-21'::timestamptz from public.orders where purchase_order = 'AKDN-80232'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '8dfc1543-38c1-4485-9ce5-8b5070fff6df'::uuid, id, true, 'Caio Nunes', '2026-07-23'::timestamptz from public.orders where purchase_order = 'AKDN-80233'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'cf844290-f751-48d3-96a9-537dec5f2523'::uuid, id, true, 'Renata Alves', '2026-07-22'::timestamptz from public.orders where purchase_order = 'AKDN-80234'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'ee779497-2532-4ec6-84e8-90b9f5715624'::uuid, id, true, 'Lucas Monteiro', '2026-07-24'::timestamptz from public.orders where purchase_order = 'AKDN-80235'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'd8f0bf1f-584f-474a-b70f-c6806915fb4c'::uuid, id, true, 'Caio Nunes', '2026-07-25'::timestamptz from public.orders where purchase_order = 'AKDN-80237'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f84781c8-2ac4-4ce2-9d14-0b33d3e295b3'::uuid, id, true, 'Renata Alves', '2026-07-26'::timestamptz from public.orders where purchase_order = 'AKDN-80238'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f4c79fee-54d7-4cb7-a7a2-4acc41717d0c'::uuid, id, true, 'Lucas Monteiro', '2026-07-28'::timestamptz from public.orders where purchase_order = 'AKDN-80239'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '9c270e03-da0e-4695-bcc8-46fe59418504'::uuid, id, 'Cancelled by demo store', 'seed', 'Marina Torres', '2026-07-28'::timestamptz from public.orders where purchase_order = 'AKDN-80240'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '84a96379-21b7-4a9e-9b24-39600d9347c7'::uuid, id, 'Cancelled by demo customer', 'seed', 'Caio Nunes', '2026-07-30'::timestamptz from public.orders where purchase_order = 'AKDN-80241'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '05dc7a2c-02e8-43b0-a12c-a03336fdaa58'::uuid, id, 'Cancelled by demo store', 'seed', 'Renata Alves', '2026-08-01'::timestamptz from public.orders where purchase_order = 'AKDN-80242'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '654c2a70-279e-4fea-a9e2-8b8fb7e6afba'::uuid, id, true, 'Lucas Monteiro', '2026-07-30'::timestamptz from public.orders where purchase_order = 'AKDN-80243'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '52fa7e98-72bb-4757-aed1-4b582fe41970'::uuid, id, true, 'Marina Torres', '2026-08-01'::timestamptz from public.orders where purchase_order = 'AKDN-80244'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '2a0b5dc1-050a-4362-b059-1f483b357202'::uuid, id, true, 'Caio Nunes', '2026-08-02'::timestamptz from public.orders where purchase_order = 'AKDN-80245'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '289e1a99-e539-4d22-a587-b2fa67f99121'::uuid, id, true, 'Renata Alves', '2026-08-01'::timestamptz from public.orders where purchase_order = 'AKDN-80246'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'df63e3ff-5de3-48d0-9bca-41310f8196aa'::uuid, id, true, 'Lucas Monteiro', '2026-08-03'::timestamptz from public.orders where purchase_order = 'AKDN-80247'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '8135586e-9a73-4425-ae23-c6eb37ad0cd5'::uuid, id, true, 'Marina Torres', '2026-08-05'::timestamptz from public.orders where purchase_order = 'AKDN-80248'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '090dfb74-fa5d-462c-a5fc-3d382c7be6bd'::uuid, id, true, 'Caio Nunes', '2026-08-04'::timestamptz from public.orders where purchase_order = 'AKDN-80249'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'd44a6352-7e52-4456-a6a6-8ea72a852156'::uuid, id, true, 'Renata Alves', '2026-08-06'::timestamptz from public.orders where purchase_order = 'AKDN-80250'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'd4c3b2ec-265b-43cb-839f-0b3f5aa358e0'::uuid, id, true, 'Lucas Monteiro', '2026-08-07'::timestamptz from public.orders where purchase_order = 'AKDN-80251'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'ffa49158-b9fd-42e3-b843-b7c65e248525'::uuid, id, true, 'Marina Torres', '2026-08-06'::timestamptz from public.orders where purchase_order = 'AKDN-80252'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '656d7a07-1906-4ea4-a682-404668f68a37'::uuid, id, true, 'Caio Nunes', '2026-08-08'::timestamptz from public.orders where purchase_order = 'AKDN-80253'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '1cd34f05-f6d5-44ad-afe3-96916388df48'::uuid, id, true, 'Renata Alves', '2026-08-10'::timestamptz from public.orders where purchase_order = 'AKDN-80254'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'ce0977e4-f4d4-46aa-a2de-7d8e454c5574'::uuid, id, true, 'Lucas Monteiro', '2026-08-09'::timestamptz from public.orders where purchase_order = 'AKDN-80255'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '6c8cc2b1-d1ab-455d-aae3-c8bc81d2fc4c'::uuid, id, true, 'Caio Nunes', '2026-08-13'::timestamptz from public.orders where purchase_order = 'AKDN-80257'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '8d84cce3-a05a-4695-8f89-3e3cbe1d5a27'::uuid, id, true, 'Renata Alves', '2026-08-11'::timestamptz from public.orders where purchase_order = 'AKDN-80258'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '7601a2b5-4526-42df-82a7-32c56be5122d'::uuid, id, true, 'Lucas Monteiro', '2026-08-13'::timestamptz from public.orders where purchase_order = 'AKDN-80259'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '7ee0d48f-0ef9-404d-b17c-17e5ce961950'::uuid, id, 'Cancelled by demo store', 'seed', 'Marina Torres', '2026-08-14'::timestamptz from public.orders where purchase_order = 'AKDN-80260'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '02196d70-bfb5-4c72-a3cd-fd1b5c515f4d'::uuid, id, 'Cancelled by demo customer', 'seed', 'Caio Nunes', '2026-08-16'::timestamptz from public.orders where purchase_order = 'AKDN-80261'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '609d3450-c4c5-467f-8888-258fdc1c4d92'::uuid, id, 'Cancelled by demo store', 'seed', 'Renata Alves', '2026-08-18'::timestamptz from public.orders where purchase_order = 'AKDN-80262'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'b6bc5d71-43ac-4232-8c79-aad58bd7889d'::uuid, id, true, 'Lucas Monteiro', '2026-08-18'::timestamptz from public.orders where purchase_order = 'AKDN-80263'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'c9ee44cb-fc54-47f2-863a-bd5a3eb9485e'::uuid, id, true, 'Marina Torres', '2026-08-17'::timestamptz from public.orders where purchase_order = 'AKDN-80264'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '06ad89d3-f6a6-4dfd-9300-0833f26d874c'::uuid, id, true, 'Caio Nunes', '2026-08-18'::timestamptz from public.orders where purchase_order = 'AKDN-80265'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '29725f07-5f21-4fcf-bdf3-dd600caed591'::uuid, id, true, 'Renata Alves', '2026-08-20'::timestamptz from public.orders where purchase_order = 'AKDN-80266'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '615d108e-d8ea-414a-9961-19087af49643'::uuid, id, true, 'Lucas Monteiro', '2026-08-19'::timestamptz from public.orders where purchase_order = 'AKDN-80267'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '809ebb7c-d582-433b-ae15-c21cb7107f35'::uuid, id, true, 'Marina Torres', '2026-08-21'::timestamptz from public.orders where purchase_order = 'AKDN-80268'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '239cb217-9082-4399-8157-eb9b2f0bd2ce'::uuid, id, true, 'Caio Nunes', '2026-08-23'::timestamptz from public.orders where purchase_order = 'AKDN-80269'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'fd386653-9c12-4d85-b059-8e9cc5c9f149'::uuid, id, true, 'Renata Alves', '2026-08-22'::timestamptz from public.orders where purchase_order = 'AKDN-80270'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f786a482-d38c-4c06-9518-e37b8f7223f2'::uuid, id, true, 'Lucas Monteiro', '2026-08-23'::timestamptz from public.orders where purchase_order = 'AKDN-80271'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'c683cd36-5e95-42f7-90f6-60dfc3d9abf9'::uuid, id, true, 'Marina Torres', '2026-08-25'::timestamptz from public.orders where purchase_order = 'AKDN-80272'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '97a3573f-3ce1-47ea-9664-f45e226ab576'::uuid, id, true, 'Caio Nunes', '2026-08-24'::timestamptz from public.orders where purchase_order = 'AKDN-80273'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '859e4c29-5a72-4a35-ac7f-7340c8f1907f'::uuid, id, true, 'Renata Alves', '2026-08-26'::timestamptz from public.orders where purchase_order = 'AKDN-80274'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '578c129d-1242-4660-93f5-27f8dde59747'::uuid, id, true, 'Lucas Monteiro', '2026-08-28'::timestamptz from public.orders where purchase_order = 'AKDN-80275'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '0a773577-8db0-4017-987b-3806892266a0'::uuid, id, true, 'Caio Nunes', '2026-08-29'::timestamptz from public.orders where purchase_order = 'AKDN-80277'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '4d521513-3beb-45d0-999c-cc40b7162cbe'::uuid, id, true, 'Renata Alves', '2026-08-30'::timestamptz from public.orders where purchase_order = 'AKDN-80278'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '5ff963ec-a4eb-462e-9daa-d1b1059203ed'::uuid, id, true, 'Lucas Monteiro', '2026-08-29'::timestamptz from public.orders where purchase_order = 'AKDN-80279'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'fa11c2bb-07e5-4682-bb99-da86abbc5c66'::uuid, id, true, 'Caio Nunes', '2026-09-02'::timestamptz from public.orders where purchase_order = 'AKDN-80281'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'a824a5fa-11db-4e56-8b9f-2582e7852b51'::uuid, id, true, 'Renata Alves', '2026-09-01'::timestamptz from public.orders where purchase_order = 'AKDN-80282'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f83e4c42-3811-4452-8e5f-60aaf4dc8fde'::uuid, id, true, 'Lucas Monteiro', '2026-09-03'::timestamptz from public.orders where purchase_order = 'AKDN-80283'
on conflict (id) do nothing;

commit;
