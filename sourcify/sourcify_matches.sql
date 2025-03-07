create or replace view sourcify__sourcify_matches as (
    with 
        'https://export.sourcify.app' as base_url,

        (
            select  
                arrayMap(
                    x -> splitByString('/', x::String)[2],
                    files.sourcify_matches
                )
            from url(base_url || '/manifest.json')
        ) as files,

        (
            select base_url || '/sourcify_matches/{' || arrayStringConcat(files, ',') || '}'
        ) as glob_url

    select * from url(glob_url, 'Parquet', '
        id Nullable(Int64),
        verified_contract_id Nullable(Int64),
        creation_match Nullable(String),
        runtime_match Nullable(String),
        created_at Nullable(DateTime64(9)),
        metadata Nullable(String)
    ')

    settings 
        remote_filesystem_read_prefetch=true,
        glob_expansion_max_elements=1000
)

comment $comment${
    "short": "Sourcify matches from the Sourcify repository.",
    "url": "https://docs.sourcify.dev/docs/repository/sourcify-database/",
    "usage": "select * from sourcify__sourcify_matches limit 10"
}$comment$;