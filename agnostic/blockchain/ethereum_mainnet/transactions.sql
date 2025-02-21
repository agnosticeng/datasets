create or replace view agnostic__blockchain__ethereum_mainnet__transactions as
select
    date,
    *
from s3 ('https://data.agnostic.dev/ethereum-mainnet-pq/transactions/date=*/*.parquet') 
settings 
    use_hive_partitioning = 1,
    allow_suspicious_low_cardinality_types = 1;