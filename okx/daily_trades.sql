create or replace view okx__daily_trades as (
    with 
        (
            select arrayMap(
                x -> toDate(x),  
                range(toInt32({from:Date}), toInt32({to:Date}))
            )
        ) as dates,

        (
            select arrayMap(
                x -> replaceAll(toString(x), '-', '') || '/' || {pair:String} || '-trades-' || x,
                dates
            )
        ) as files,

        (
            if (
                length(dates) = 1,
                toString(dates[1]),
                '{' || arrayStringConcat(files, ',') || '}'
            )
        ) as files_pattern

    select
        _path as file_path,
        trade_id,
        side,
        size,
        price,
        toDateTime64(created_time/1000, 3, 'UTC') as created_time
    from s3(
        'https://www.okx.com/cdn/okex/traderecords/trades/daily/' || files_pattern || '.zip :: *.csv',
        NOSIGN,
        CSVWithNames,
        '
            trade_id UInt64,
            side LowCardinality(String),
            size Float64,
            price Float64,
            created_time Int64
        '
    )   
    settings 
        s3_ignore_file_doesnt_exist=1,
        input_format_with_names_use_header=0
)
comment $heredoc${
    "short": "Daily trades of spot pairs on the OKX exchange.",
    "url": "https://www.okx.com/data-download",
    "usage": "select * from okx__daily_trades(pair='1INCH-EUR', from='2025-02-02', to='2025-02-05')",
    "columns": [
        {"name": "file_path"        , "type": "String"},
        {"name": "trade_id"         , "type": "UInt64"},
        {"name": "side"             , "type": "LowCardinality(String)"},
        {"name": "price"            , "type": "Float64"},
        {"name": "created_time"     , "type": "DateTime64(3,'UTC')"}
    ]
}$heredoc$;