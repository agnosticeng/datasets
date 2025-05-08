create or replace view agnostic__blockchain__ethereum_mainnet__token_erc20_balances as (
    select
        toDate(timestamp) as date,
        *
    from iceberg('https://data.agnostic.dev/agnostic-ethereum-mainnet/token_erc20_balances', settings iceberg_use_version_hint=true)
)
comment $comment${
    "short": "Historical balances for every pair of ERC20-token/wallet.",
    "url": "https://agnostic.dev/",
    "usage": "select * from agnostic__blockchain__ethereum_mainnet__token_erc20_balances limit 10"
}$comment$;