create or replace view oli__labels_decoded as (
    select * from url('https://api.growthepie.xyz/v1/oli/labels_decoded.parquet')
)

comment $comment${
    "short": "Open Lable Initiative decoded labels ",
    "url": "https://www.openlabelsinitiative.org/",
    "usage": "select * from oli__labels_decoded limit 10"
}$comment$;