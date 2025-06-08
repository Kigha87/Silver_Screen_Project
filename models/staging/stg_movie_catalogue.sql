with clean_movie as (
    select * from {{ source('Silver_Screen_Project', 'movie_catalogue') }}
)

select
    movie_id,
    movie_title,
    coalesce(genre, 'Unknown') as genre,
    studio
from
    clean_movie