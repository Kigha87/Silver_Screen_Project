{{
    config(
        materialized='table'
    )
}}


with nj003_sales as (
    select * from {{ source('Silver_Screen_Project', 'nj_003') }}
)

select
    date_trunc('month', timestamp::date) as month,
    details as movie_id, 
    'NJ_003' as location,
    sum(amount) as tickets_sold, 
    sum(total_value) as revenue
from
    nj003_sales
where
    product_type = 'ticket'
group by
    1, 2, 3