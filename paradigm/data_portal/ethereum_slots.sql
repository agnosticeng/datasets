create or replace view paradigm__data_portal__ethereum_slots as (
    with 
        'https://datasets.paradigm.xyz/datasets/ethereum_slots' as base_url,

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
        contract_address Nullable(String),
        slot Nullable(String),
        value Nullable(String),
        first_updated_block Nullable(Int32),
        last_updated_block Nullable(Int32),
        n_tx_updates Nullable(Int32)
    ')

    settings 
        remote_filesystem_read_prefetch=true,
        glob_expansion_max_elements=1000
)

comment $heredoc${
    "short": "All slots of each contract, including historical usage metadata.",
    "url": "https://github.com/paradigmxyz/paradigm-data-portal/tree/main",
    "usage": "select * from paradigm__data_portal__ethereum_slots limit 10"
}$heredoc$;