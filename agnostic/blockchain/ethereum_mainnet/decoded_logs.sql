create or replace view agnostic__blockchain__ethereum_mainnet__decoded_logs as (
    select
        date,
        *
    from s3 ('https://data.agnostic.dev/ethereum-mainnet-pq/decoded_logs/date=*/*.parquet')
)
comment $comment${
    "short": "Decoded event log data.",
    "url": "https://agnostic.dev/",
    "usage": "select * from agnostic__blockchain__ethereum_mainnet__decoded_logs limit 10"
}$comment$
settings 
    use_hive_partitioning = 1,
    allow_suspicious_low_cardinality_types = 1;