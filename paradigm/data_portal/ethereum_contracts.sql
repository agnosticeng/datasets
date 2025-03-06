create or replace view paradigm__data_portal__ethereum_contracts as (
    with 
        'https://datasets.paradigm.xyz/datasets/ethereum_contracts' as base_url,

        (
            select 
                files.name
            from s3(base_url || '/dataset_manifest.json', NOSIGN)
        ) as files,

        (
            select 
                base_url || '/' || '{' || arrayStringConcat(files, ',') || '}'
        ) as glob_url

    select * from s3(glob_url, NOSIGN, 'Parquet', '
        block_number Nullable(Int64),
        create_index Nullable(Int64),
        transaction_hash Nullable(String),
        contract_address Nullable(String),
        deployer Nullable(String),
        factory Nullable(String),
        init_code Nullable(String),
        code Nullable(String),
        init_code_hash Nullable(String),
        code_hash Nullable(String)
    ')

    settings 
        remote_filesystem_read_prefetch=true,
        glob_expansion_max_elements=1000
)

comment $comment${
    "short": "All historical contract deployments.",
    "url": "https://github.com/paradigmxyz/paradigm-data-portal/tree/main",
    "usage": "select count(*) from paradigm__data_portal__ethereum_contracts where block_number between 15000000 and 15000100"
}$comment$;