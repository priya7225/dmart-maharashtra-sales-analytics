{{ config(materialized='table') }}

select
    store_id,
    sale_date,
    sum(coalesce(revenue, 0)) as total_revenue,
    sum(coalesce(quantity, 0)) as total_quantity_sold,
    count(distinct transaction_id) as transaction_count,
    {{ safe_divide('sum(revenue)', 'count(distinct transaction_id)') }} as average_basket_size,
    sum(case when is_return then 1 else 0 end) as return_transaction_count
from {{ ref('fact_sales') }}
group by
    store_id,
    sale_date