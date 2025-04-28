create or replace view agnostic__blockchain__base_mainnet__logs as (
    select
        toDate(timestamp) as date,
        *
    from iceberg('https://data.agnostic.dev/agnostic-base-mainnet/logs', settings iceberg_use_version_hint=true)
)
comment $comment${
    "short": "Event log data.",
    "url": "https://agnostic.dev/",
    "usage": "select * from agnostic__blockchain__base_mainnet__logs limit 10"
}$comment$;