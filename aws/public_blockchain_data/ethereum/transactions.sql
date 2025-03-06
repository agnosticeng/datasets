create or replace view aws__public_blockchain_data__ethereum__transactions as (
    select
        date,
        *
    from s3('https://aws-public-blockchain.s3.us-east-2.amazonaws.com/v1.0/eth/transactions/date=*/*.snappy.parquet', NOSIGN)
)
comment $comment${
    "url": "https://registry.opendata.aws/aws-public-blockchain/",
    "usage": "select * from aws__public_blockchain_data__ethereum__transactions limit 10"
}$comment$
settings 
    use_hive_partitioning = 1,
    allow_suspicious_low_cardinality_types = 1;