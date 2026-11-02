select
    fact.transaction_id,
    fact.product_id
from {{ ref('fact_sales') }} as fact 
left join {{ ref('dim_product') }} as pd on fact.product_id = pd.product_id
where fact.product_id is not null
and pd.product_id is null ;