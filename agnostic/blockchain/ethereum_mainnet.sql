create
or replace view agnostic__blockchain__ethereum_mainnet__blocks as
select
    date,
    *
from
    s3 (
        'https://data.agnostic.dev/ethereum-mainnet-pq/blocks/date=*/*.parquet'
    ) settings use_hive_partitioning = 1,
    allow_suspicious_low_cardinality_types = 1;

create
or replace view agnostic__blockchain__ethereum_mainnet__logs as
select
    date,
    *
from
    s3 (
        'https://data.agnostic.dev/ethereum-mainnet-pq/logs/date=*/*.parquet'
    ) settings use_hive_partitioning = 1,
    allow_suspicious_low_cardinality_types = 1;

create
or replace view agnostic__blockchain__ethereum_mainnet__transactions as
select
    date,
    *
from
    s3 (
        'https://data.agnostic.dev/ethereum-mainnet-pq/transactions/date=*/*.parquet'
    ) settings use_hive_partitioning = 1,
    allow_suspicious_low_cardinality_types = 1;

create
or replace view agnostic__blockchain__ethereum_mainnet__traces as
select
    date,
    *
from
    s3 (
        'https://data.agnostic.dev/ethereum-mainnet-pq/traces/date=*/*.parquet'
    ) settings use_hive_partitioning = 1,
    allow_suspicious_low_cardinality_types = 1;

create
or replace view agnostic__blockchain__ethereum_mainnet__decoded_logs as
select
    date,
    *
from
    s3 (
        'https://data.agnostic.dev/ethereum-mainnet-pq/decoded_logs/date=*/*.parquet'
    ) settings use_hive_partitioning = 1,
    allow_suspicious_low_cardinality_types = 1;
