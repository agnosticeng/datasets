create or replace view binance__spot__daily_klines as (
    with 
        (
            select arrayMap(
                x -> toDate(x),  
                range(toInt32({from:Date}), toInt32({to:Date}))
            )
        ) as dates,

        (
            if (
                length(dates) = 1,
                toString(dates[1]),
                '{' || arrayStringConcat(dates, ',') || '}'
            )
        ) as date_pattern

    select 
        _path as file_path,
        toDateTime64(open_time/1000000, 3, 'UTC') as open_time,
        open,
        high,
        low,
        close,
        volume,
        toDateTime64(close_time/1000000, 3, 'UTC') as close_time,
        quote_asset_volume,
        number_of_trades,
        taker_buy_base_asset_volume,
        taker_buy_quote_asset_volume,
        ignore
    from s3(
        'https://data.binance.vision/data/spot/daily/klines/' || 
        {pair:String} || 
        '/' ||
        {interval:String} ||
        '/' || 
        {pair:String} ||
        '-' ||
        {interval:String} ||
        '-' ||
        date_pattern ||
        '.zip :: *.csv',
        NOSIGN,
        CSV,
        '
            open_time Int64,
            open Float64,
            high Float64,
            low Float64,
            close Float64,
            volume Float64,
            close_time Int64,
            quote_asset_volume Float64,
            number_of_trades UInt64,
            taker_buy_base_asset_volume Float64,
            taker_buy_quote_asset_volume Float64,
            ignore Int8
        '
    )
    settings 
        s3_ignore_file_doesnt_exist=1
)
comment $heredoc${
    "short": "Daily klines of spot pairs on the Binance exchange.",
    "url": "https://github.com/binance/binance-public-data/",
    "usage": "select * from binance__spot__daily_klines(pair='WBTCETH', interval='15m', from='2025-01-01', to='2025-01-03')",
    "columns": [
        {"name": "file_path"                    , "type": "String"},
        {"name": "open_time"                    , "type": "DateTime64(3,'UTC')"},
        {"name": "open"                         , "type": "Float64"},
        {"name": "high"                         , "type": "Float64"},
        {"name": "low"                          , "type": "Float64"},
        {"name": "close"                        , "type": "Float64"},
        {"name": "volume"                       , "type": "Float64"},
        {"name": "close_time"                   , "type": "DateTime64(3,'UTC')"},
        {"name": "quote_asset_volume"           , "type": "Float64"},
        {"name": "number_of_trades"             , "type": "UInt64"},
        {"name": "taker_buy_base_asset_volume"  , "type": "Float64"},
        {"name": "taker_buy_quote_asset_volume" , "type": "Float64"},
        {"name": "ignore"                       , "type": "Int8"},
    ]
}$heredoc$;