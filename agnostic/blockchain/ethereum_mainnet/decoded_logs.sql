create or replace view agnostic__blockchain__ethereum_mainnet__decoded_logs as (
    select
        toDate(timestamp) as date,
        *
    from iceberg('https://data.agnostic.dev/agnostic-ethereum-mainnet/decoded_logs', settings iceberg_use_version_hint=true)
)
comment $comment${
    "short": "Decoded event log data.",
    "url": "https://agnostic.dev/",
    "usage": "select * from agnostic__blockchain__ethereum_mainnet__decoded_logs limit 10"
}$comment$;