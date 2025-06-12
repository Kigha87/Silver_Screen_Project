{{
    config(
        materialized='table'
    )
}}

with
movies_revenue as (
select * from {{ ref( 'int_movies_revenue') }}
),
movie_catalogue as (
select * from {{ ref('stg_movie_catalogue') }}
),
movie_costs as (
select * from {{ ref('stg_invoices') }}
)

select
us.movie_id, 
mc.movie_title,
mc.genre, 
mc.studio, 
us.month, 
us.location,
i.rental_cost,  
us.tickets_sold, 
us.revenue

from
movies_revenue as us
left join movie_catalogue as mc  
on us.movie_id = mc.movie_id
left join movie_costs as i
on us.movie_id = i.movie_id










