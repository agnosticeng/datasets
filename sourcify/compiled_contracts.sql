create or replace view sourcify__compiled_contracts as (
    with 
        'https://export.sourcify.app' as base_url,

        (
            select 
                files.compiled_contracts
            from url(base_url || '/manifest.json')
        ) as files,

        (
            select base_url || '/{' || arrayStringConcat(files, ',') || '}'
        ) as glob_url

    select * from url(glob_url, 'Parquet', '
        id Nullable(String),
        created_at Nullable(DateTime64(9)),
        updated_at Nullable(DateTime64(9)),
        created_by Nullable(String),
        updated_by Nullable(String),
        compiler Nullable(String),
        version Nullable(String),
        language Nullable(String),
        name Nullable(String),
        fully_qualified_name Nullable(String),
        compiler_settings Nullable(String),
        compilation_artifacts Nullable(String),
        creation_code_hash Nullable(String),
        creation_code_artifacts Nullable(String),
        runtime_code_hash Nullable(String),
        runtime_code_artifacts Nullable(String)
    ')

    settings 
        remote_filesystem_read_prefetch=true,
        glob_expansion_max_elements=1000
)

comment $heredoc${
    "short": "Compiled contracts from the Sourcify repository.",
    "url": "https://docs.sourcify.dev/docs/repository/sourcify-database/",
    "usage": "select name, language, version, compiler  from sourcify__compiled_contracts limit 100"
}$heredoc$;