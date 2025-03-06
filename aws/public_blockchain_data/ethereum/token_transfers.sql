create or replace view aws__public_blockchain_data__ethereum__token_transfers as (
    select
        date,
        *
    from s3('https://aws-public-blockchain.s3.us-east-2.amazonaws.com/v1.0/eth/token_transfers/date=*/*.snappy.parquet', NOSIGN)
)
comment $comment${
    "url": "https://registry.opendata.aws/aws-public-blockchain/",
    "usage": "select * from aws__public_blockchain_data__ethereum__token_transfers limit 10"
}$comment$
settings 
    use_hive_partitioning = 1,
    allow_suspicious_low_cardinality_types = 1;