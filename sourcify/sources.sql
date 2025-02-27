create or replace view sourcify__sources as (
    with 
        'https://export.sourcify.app' as base_url,

        (
            select 
                files.sources
            from url(base_url || '/manifest.json')
        ) as files,

        (
            select base_url || '/{' || arrayStringConcat(files, ',') || '}'
        ) as glob_url

    select * from url(glob_url, 'Parquet', '
        source_hash Nullable(String),
        source_hash_keccak Nullable(String),
        content Nullable(String),
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
    "short": "Contract source files from the Sourcify repository.",
    "url": "https://docs.sourcify.dev/docs/repository/sourcify-database/",
    "usage": "select * from sourcify__sources limit 10"
}$heredoc$;