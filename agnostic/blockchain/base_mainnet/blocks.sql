create or replace view agnostic__blockchain__base_mainnet__blocks as (
    select
        toDate(timestamp) as date,
        *
    from iceberg('https://data.agnostic.dev/agnostic-base-mainnet/blocks', settings iceberg_use_version_hint=true)
)
comment $comment${
    "short": "Block level data.",
    "url": "https://agnostic.dev/",
    "usage": "select * from agnostic__blockchain__base_mainnet__blocks limit 10"
}$comment$;