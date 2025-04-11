create or replace view agnostic__blockchain__ethereum_mainnet__transactions as (
    select
        toDate(timestamp) as date,
        *
    from iceberg('https://data.agnostic.dev/agnostic-ethereum-mainnet/transactions')
)
comment $comment${
    "short": "Transaction data",
    "url": "https://agnostic.dev/",
    "usage": "select * from agnostic__blockchain__ethereum_mainnet__transactions limit 10"
}$comment$;