create or replace view agnostic__blockchain__ethereum_mainnet__logs as (
    select
        date,
        *
    from s3 ('https://data.agnostic.dev/agnostic-data-pq-ethereum-mainnet/logs/date=*/*.parquet') 
)
comment $comment${
    "short": "Event log data.",
    "url": "https://agnostic.dev/",
    "usage": "select * from agnostic__blockchain__ethereum_mainnet__logs limit 10"
}$comment$
settings 
    use_hive_partitioning = 1,
    allow_suspicious_low_cardinality_types = 1;