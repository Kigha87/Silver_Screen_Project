{{
    config(
        materialized='table'
    )
}}



with nj001_sales as (
    select * from {{ source('Silver_Screen_Project', 'nj_001') }}
)

select
    date_trunc('month', timestamp::date) as month,
    movie_id,
    'NJ_001' as location,
    sum(ticket_amount) as tickets_sold,
    sum(transaction_total) as revenue
from
    nj001_sales
group by
    1, 2, 3