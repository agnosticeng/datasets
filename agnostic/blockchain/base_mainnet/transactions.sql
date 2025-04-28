create or replace view agnostic__blockchain__base_mainnet__transactions as (
    select
        toDate(timestamp) as date,
        *
    from iceberg('https://data.agnostic.dev/agnostic-base-mainnet/transactions', settings iceberg_use_version_hint=true)
)
comment $comment${
    "short": "Transaction data",
    "url": "https://agnostic.dev/",
    "usage": "select * from agnostic__blockchain__base_mainnet__transactions limit 10"
}$comment$;