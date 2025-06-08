with costs as (
    select * from {{ source('Silver_Screen_Project', 'rental_costs') }}
)

select
    -- Convert 'YYYY-MM' string to a proper date (first day of the month)
    to_date('YYYY-MM-DD') as month,
    movie_id,
    location_id as location,
    rental_cost
from
    costs