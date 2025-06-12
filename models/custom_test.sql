-- this test ensures that no record in the final table has a negative revenue value
select
    *
from
    {{ ref('marts_monthly_movie_performance') }}
where
    revenue < 0