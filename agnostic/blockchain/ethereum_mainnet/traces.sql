create or replace view agnostic__blockchain__ethereum_mainnet__traces as (
    select
        toDate(timestamp) as date,
        *
    from iceberg('https://data.agnostic.dev/agnostic-ethereum-mainnet/traces', settings iceberg_use_version_hint=true)
)
comment $comment${
    "short": "Transaction trace data.",
    "url": "https://agnostic.dev/",
    "usage": "select * from agnostic__blockchain__ethereum_mainnet__traces limit 10"
}$comment$;