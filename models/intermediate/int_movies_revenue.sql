{{
    config(
        materialized='table'
    )
}}


with nj001 as (
    select * from {{ ref('stg_nj001_sales') }}
),

nj002 as (
    select * from {{ ref('stg_nj002_sales') }}
),

nj003 as (
    select * from {{ ref('stg_nj003_sales') }}
)

select * from nj001
union all
select * from nj002
union all
select * from nj003