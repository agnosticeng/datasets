create or replace view sourcify__contracts as (
    with 
        'https://export.sourcify.app' as base_url,

        (
            select 
                files.contracts
            from url(base_url || '/manifest.json')
        ) as files,

        (
            select base_url || '/{' || arrayStringConcat(files, ',') || '}'
        ) as glob_url

    select * from url(glob_url, 'Parquet', '
        id Nullable(String),
        creation_code_hash Nullable(String),
        runtime_code_hash Nullable(String),
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
    "short": "Contracts from the Sourcify repository.",
    "url": "https://docs.sourcify.dev/docs/repository/sourcify-database/",
    "usage": "select * from sourcify__contracts limit 10"
}$heredoc$;