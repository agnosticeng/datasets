create or replace view paradigm__data_portal__ethereum_native_transfers as (
    with 
        'https://datasets.paradigm.xyz/datasets/ethereum_native_transfers' as base_url,

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
        transfer_index Nullable(Int64),
        transaction_hash Nullable(String),
        from_address Nullable(String),
        to_address Nullable(String),
        value Nullable(String)
    ')

    settings 
        remote_filesystem_read_prefetch=true,
        glob_expansion_max_elements=1000
)

comment $comment${
    "short": "All native transfers in similar format to ERC20 Transfers (excluding tx fees).",
    "url": "https://github.com/paradigmxyz/paradigm-data-portal/tree/main",
    "usage": "select count(*) from paradigm__data_portal__ethereum_native_transfers where block_number between 15000000 and 15000100"
}$comment$;