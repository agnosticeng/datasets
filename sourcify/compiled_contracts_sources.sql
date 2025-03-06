create or replace view sourcify__compiled_contracts_sources as (
    with 
        'https://export.sourcify.app' as base_url,

        (
            select  
                arrayMap(
                    x -> splitByString('/', x::String)[2],
                    files.compiled_contracts_sources
                )
            from url(base_url || '/manifest.json')
        ) as files,

        (
            select base_url || '/compiled_contracts_sources/{' || arrayStringConcat(files, ',') || '}'
        ) as glob_url

    select * from s3(glob_url, 'Parquet', '
        id Nullable(String),
        compilation_id Nullable(String),
        source_hash Nullable(String),
        path Nullable(String)
    ')

    settings 
        remote_filesystem_read_prefetch=true,
        glob_expansion_max_elements=1000
)

comment $comment${
    "short": "Compiled contract sources from the Sourcify repository.",
    "url": "https://docs.sourcify.dev/docs/repository/sourcify-database/",
    "usage": "select * from sourcify__compiled_contracts_sources limit 10"
}$comment$;