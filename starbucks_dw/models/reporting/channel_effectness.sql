{{
  config(
    materialized = 'table',
    )
}}

with transaction_channels as (SELECT transaction_id,
            t.offer_id,
            channel,
            transaction_status

FROM {{ ref('fct_customer_transactions') }} t
left join {{ref('dim_offer')}} of
on t.offer_id = of.offer_id),

last_table as (select channel,
        count(*) FILTER (WHERE transaction_status = 'completed') AS completed,
        count(*) FILTER (WHERE transaction_status = 'received') AS received,
        count(*)FILTER (WHERE transaction_status = 'viewed') AS viewed--,
        --count(*) FILTER (WHERE transaction_status = 'transaction') AS transaction
from transaction_channels
group by channel)

select *,
   completed::decimal/NULLIF(received, 0) as effect_received,
   completed::decimal/NULLIF(viewed, 0) as effect_viewed
from last_table
