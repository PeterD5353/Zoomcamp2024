{{
    config(
        materialized='table'
    )
}}

with fhv_tripdata as (
    select *
    from {{ ref('stg_fhv_tripdata') }}
),
dim_zones as (
    select *
    from {{ ref('dim_zones') }}
)


SELECT
    t1.PUlocationID,
    t1.DOlocationID,
    t2_pu.borough AS PUborough,
    t2_pu.zone AS PUzone,
    t2_pu.service_zone AS PUservice_zone,
    t2_do.borough AS DOborough,
    t2_do.zone AS DOzone,
    t2_do.service_zone AS DOservice_zone
FROM
    fhv_tripdata t1
JOIN
    dim_zones t2_pu ON t1.PUlocationID = t2_pu.locationid
JOIN
    dim_zones t2_do ON t1.DOlocationID = t2_do.locationid
WHERE
    t1.PUlocationID IS NOT NULL
    AND t1.DOlocationID IS NOT NULL
