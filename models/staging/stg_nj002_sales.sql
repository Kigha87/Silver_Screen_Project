{{
    config(
        materialized='table'
    )
}}


with nj002_sales as (
    select * from {{ source('Silver_Screen_Project', 'nj_002') }}
)

select
    date_trunc('month', date) as month,
    movie_id,
    'NJ_002' as location,
    sum(ticket_amount) as tickets_sold,
    sum(total_earned) as revenue
from
    nj002_sales
group by
    1, 2, 3