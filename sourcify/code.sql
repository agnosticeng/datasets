create or replace view sourcify__code as (
    with 
        'https://export.sourcify.app' as base_url,

        (
            select  
                arrayMap(
                    x -> splitByString('/', x::String)[2],
                    files.code
                )
            from url(base_url || '/manifest.json')
        ) as files,

        (
            select base_url || '/code/{' || arrayStringConcat(files, ',') || '}'
        ) as glob_url

    select * from s3(glob_url, 'Parquet', '
        code_hash Nullable(String),
        code Nullable(String),
        code_hash_keccak Nullable(String),
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
    "short": "Contracts code from the Sourcify repository.",
    "url": "https://docs.sourcify.dev/docs/repository/sourcify-database/",
    "usage": "select * from sourcify__code limit 10"
}$heredoc$;