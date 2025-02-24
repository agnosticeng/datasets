create or replace view aws__public_blockchain_data__sonarx__provenance__block_results as
select
    date,
    *
from s3('https://aws-public-blockchain.s3.us-east-2.amazonaws.com/v1.1/sonarx/provenance/block_results/date=*/*.snappy.parquet', NOSIGN)
settings 
    use_hive_partitioning = 1,
    allow_suspicious_low_cardinality_types = 1;