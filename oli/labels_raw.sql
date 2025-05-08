create or replace view oli__labels_raw as (
    select * from url('https://api.growthepie.xyz/v1/oli/labels_raw.parquet')
)

comment $comment${
    "short": "Open Lable Initiative raw labels ",
    "url": "https://www.openlabelsinitiative.org/",
    "usage": "select * from oli__labels_raw limit 10"
}$comment$;