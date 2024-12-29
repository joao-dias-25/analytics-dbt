{{
  config(
    materialized = 'table',
    )
}}

with customers as (
SELECT *,
    {{segmentation_age("fct_customer_transactions.age")}} as age_segment
FROM {{ ref('fct_customer_transactions') }}
)
select age_segment, gender, transaction_status, count(*) as number_transaction
from customers
where transaction_status = 'completed'
group by age_segment, gender, transaction_status
order by number_transaction desc
