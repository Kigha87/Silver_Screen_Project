with movie_costs as (

    select * 
    from {{ source('Silver_Screen_Project', 'invoices') }}
where
        movie_id is not null
        and location_id is not null
        and month is not null
)


select
    date_trunc('month', month::date) as month,
    movie_id,
    location_id as location,
    sum(total_invoice_sum) as rental_cost
from
    movie_costs
group by
    1, 2, 3




























