create or replace view agnostic__blockchain__ethereum_mainnet__decoded_logs as (
    select
        *
    from iceberg('https://data.agnostic.dev/agnostic-data-ice-ethereum-mainnet/decoded_logs')
)
comment $comment${
    "short": "Decoded event log data.",
    "url": "https://agnostic.dev/",
    "usage": "select * from agnostic__blockchain__ethereum_mainnet__decoded_logs limit 10"
}$comment$
;