create or replace view flashbots__mempool_dumpster__ethereum_mainnet as (
    with 
        (
            select arrayMap(
                x -> toDate(x),  
                range(toInt32({from:Date}), toInt32({to:Date}))
            )
        ) as dates,

        (
            select arrayMap(
                x -> DATE_FORMAT(toDate(x), '%Y-%m') || '/' || toString(x),
                dates
            )
        ) as files,

        (
            if (
                length(files) = 1,
                toString(files[1]),
                '{' || arrayStringConcat(files, ',') || '}'
            )
        ) as files_pattern

    select 
        _path as file_path,
        *
    from url(
        'https://mempool-dumpster.flashbots.net/ethereum/mainnet/' || files_pattern || '.parquet',
        'Parquet',
        '
            timestamp Nullable(DateTime64(3)),
            hash Nullable(String),
            chainId Nullable(String),
            txType Nullable(Int64),
            from Nullable(String),
            to Nullable(String),
            value Nullable(String),
            nonce Nullable(String),
            gas Nullable(String),
            gasPrice Nullable(String),
            gasTipCap Nullable(String),
            gasFeeCap Nullable(String),
            dataSize Nullable(Int64),
            data4Bytes Nullable(String),
            sources Array(Nullable(String)),
            includedAtBlockHeight Nullable(Int64),
            includedBlockTimestamp Nullable(DateTime64(3)),
            inclusionDelayMs Nullable(Int64),
            rawTx Nullable(String)
        '
    )
)
comment $heredoc${
    "short": "Dump of all mempool transactions by Flashbots.",
    "url": "https://github.com/flashbots/mempool-dumpster",
    "usage": "select date_trunc('day', timestamp) as date, avg(toUInt256(gasPrice)) from flashbots__mempool_dumpster__ethereum_mainnet(from='2025-02-01', to='2025-02-10') group by date order by date asc",
    "columns": [
        {"name": "timestamp"                , "type": "Nullable(DateTime64(3))"},
        {"name": "hash"                     , "type": "Nullable(String)"},
        {"name": "chainId"                  , "type": "Nullable(String)"},
        {"name": "txType"                   , "type": "Nullable(Int64)"},
        {"name": "from"                     , "type": "Nullable(String)"},
        {"name": "to"                       , "type": "Nullable(String)"},
        {"name": "value"                    , "type": "Nullable(String)"},
        {"name": "nonce"                    , "type": "Nullable(String)"},
        {"name": "gas"                      , "type": "Nullable(String)"},
        {"name": "gasPrice"                 , "type": "Nullable(String)"},
        {"name": "gasTipCap"                , "type": "Nullable(String)"},
        {"name": "gasFeeCap"                , "type": "Nullable(String)"},
        {"name": "dataSize"                 , "type": "Nullable(Int64)"},
        {"name": "data4Bytes"               , "type": "Nullable(String)"},
        {"name": "sources"                  , "type": "Array(Nullable(String))"},
        {"name": "includedAtBlockHeight"    , "type": "Nullable(Int64)"},
        {"name": "includedBlockTimestamp"   , "type": "Nullable(DateTime64(3))"},
        {"name": "inclusionDelayMs"         , "type": "Nullable(Int64)"},
        {"name": "rawTx"                    , "type": "Nullable(String)"}
    ]
}$heredoc$;