create or replace view sourcify__verified_contracts as (
    with 
        'https://export.sourcify.app' as base_url,

        (
            select  
                arrayMap(
                    x -> splitByString('/', x::String)[2],
                    files.verified_contracts
                )
            from url(base_url || '/manifest.json')
        ) as files,

        (
            select base_url || '/verified_contracts/{' || arrayStringConcat(files, ',') || '}'
        ) as glob_url

    select * from url(glob_url, 'Parquet', '
        id Nullable(String),
        created_at Nullable(DateTime64(9)),
        updated_at Nullable(DateTime64(9)),
        created_by Nullable(String),
        updated_by Nullable(String),
        deployment_id Nullable(String),
        compilation_id Nullable(String),
        creation_match Nullable(Bool),
        creation_values Nullable(String),
        creation_transformations Nullable(String),
        runtime_match Nullable(Bool),
        runtime_values Nullable(String),
        runtime_transformations Nullable(String),
        runtime_metadata_match Nullable(Bool),
        creation_metadata_match Nullable(Bool)
    ')

    settings 
        remote_filesystem_read_prefetch=true,
        glob_expansion_max_elements=1000
)

comment $comment${
    "short": "Verified contracts from the Sourcify repository.",
    "url": "https://docs.sourcify.dev/docs/repository/sourcify-database/",
    "usage": "select * from sourcify__verified_contracts limit 10"
}$comment$;