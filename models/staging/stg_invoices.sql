with rental_costs as (

    select
        * 
    from {{ source('Silver_Screen_Project', 'invoices') }}

),

renamed as (

    select
        invoice_id,
        movie_id,
        month::date as invoice_month,
        location_id,
        total_invoice_sum as total_invoice
    from
        rental_costs

)

select
    date_trunc('month', invoice_month) as month,
    movie_id,
    location_id as location,
    max(total_invoice) as rental_cost
from
    renamed
where movie_id is not null
      and location_id is not null
      and invoice_month is not null
group by
    1, 2, 3
