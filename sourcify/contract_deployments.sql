create or replace view sourcify__contract_deployments as (
    with 
        'https://export.sourcify.app' as base_url,

        (
            select 
                files.contract_deployments
            from url(base_url || '/manifest.json')
        ) as files,

        (
            select base_url || '/{' || arrayStringConcat(files, ',') || '}'
        ) as glob_url

    select * from url(glob_url, 'Parquet', '
        id Nullable(String),
        chain_id Nullable(String),
        address Nullable(String),
        transaction_hash Nullable(String),
        block_number Nullable(Int64),
        transaction_index Nullable(Int32),
        deployer Nullable(String),
        contract_id Nullable(String),
        created_at Nullable(DateTime64(9)),
        updated_at Nullable(DateTime64(9)),
        created_by Nullable(String),
        updated_by Nullable(String)
    ')

    settings 
        remote_filesystem_read_prefetch=true,
        glob_expansion_max_elements=1000
)

comment $heredoc${
    "short": "Contract deployments from the Sourcify repository.",
    "url": "https://docs.sourcify.dev/docs/repository/sourcify-database/",
    "usage": "select * from sourcify__contract_deployments limit 10"
}$heredoc$;