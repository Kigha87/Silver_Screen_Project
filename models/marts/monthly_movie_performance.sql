with
unioned_sales as (
    select * from {{ ref('int_unioned_sales') }}
),

movie_catalogue as (
    select * from {{ ref('stg_movie_catalogue') }}
),

rental_costs as (
    select * from {{ ref('stg_rental_costs') }}
)

select
    us.movie_id,
    mc.movie_title,
    mc.genre,
    mc.studio,
    us.month,
    us.location,
    rc.rental_cost,
    us.tickets_sold,
    us.revenue
from
    unioned_sales as us
left join movie_catalogue as mc
    on us.movie_id = mc.movie_id
left join rental_costs as rc
    on us.movie_id = rc.movie_id
   and us.month = rc.month
   and us.location = rc.location