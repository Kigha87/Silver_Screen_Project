{{
    config(
        materialized='table'
    )
}}


select
    movie_id,
    movie_title,
    coalesce(genre, 'Unknown') as genre,
    studio
from
    {{ source('Silver_Screen_Project', 'movie_catalogue') }}
