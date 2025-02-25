create or replace view binance__spot__daily_agg_trades as (
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
        aggregate_trade_id,
        price,
        qty,
        first_trade_id,
        latest_trade_id,
        toDateTime64(timestamp/1000000, 3, 'UTC') as timestamp,
        is_buyer_maker,
        is_best_match
    from s3(
        'https://data.binance.vision/data/spot/daily/aggTrades/' || 
        {pair:String} || 
        '/' || 
        {pair:String} || 
        '-aggTrades-' ||
        date_pattern ||
        '.zip :: *.csv',
        NOSIGN,
        CSV,
        '
            aggregate_trade_id UInt64,
            price Float64,
            qty Float64,
            first_trade_id UInt64,
            latest_trade_id UInt64,
            timestamp UInt64,
            is_buyer_maker Bool,
            is_best_match Bool
        '
    )
)
comment $heredoc${
    "short": "Daily aggregate trades of spot pairs on the Binance exchange.",
    "url": "https://github.com/binance/binance-public-data/",
    "usage": "select * from binance__spot__daily_agg_trades(pair='WBTCETH', from='2025-01-01', to='2025-01-03')",
    "columns": [
        {"name": "aggregate_trade_id"   , "type": "UInt64"},
        {"name": "price"                , "type": "Float64"},
        {"name": "qty"                  , "type": "Float64"},
        {"name": "first_trade_id"       , "type": "UInt64"},
        {"name": "latest_trade_id"      , "type": "UInt64"},
        {"name": "timestamp"            , "type": "Int64"},
        {"name": "is_buyer_maker"       , "type": "Bool"},
        {"name": "is_best_match"        , "type": "Bool"}
    ]
}$heredoc$;