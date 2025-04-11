create or replace view agnostic__blockchain__ethereum_mainnet__logs as (
    select
        toDate(timestamp) as date,
        *
    from iceberg('https://data.agnostic.dev/agnostic-ethereum-mainnet/logs')
)
comment $comment${
    "short": "Event log data.",
    "url": "https://agnostic.dev/",
    "usage": "select * from agnostic__blockchain__ethereum_mainnet__logs limit 10"
}$comment$;