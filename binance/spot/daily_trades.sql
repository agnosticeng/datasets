create or replace view binance__spot__daily_trades as (
    select 
        trade_id,
        price,
        qty,
        quote_qty,
        fromUnixTimestamp(toInt64(time/1000000)) as time,
        is_buyer_maker,
        is_best_match
    from s3(
        'https://data.binance.vision/data/spot/daily/trades/' || 
        {pair:String} || 
        '/' || 
        {pair:String} || 
        '-trades-{' || (
            select arrayStringConcat(
                arrayMap(
                    x -> toDate(x),  
                    range(toInt32({from:Date}), toInt32({to:Date}))
                ),
                ','
            )
        )
        || '}.zip :: *.csv',
        NOSIGN,
        CSV,
        '
            trade_id UInt64,
            price Float64,
            qty Float64,
            quote_qty Float64,
            time UInt64,
            is_buyer_maker Bool,
            is_best_match Bool
        '
    )
)
comment $heredoc${
    "short": "Daily trades of spot pairs on the Binance exchange.",
    "url": "https://github.com/binance/binance-public-data/",
    "usage": "select * from binance__spot__daily_trades(pair='WBTCETH', from='2025-01-01', to='2025-01-03')",
    "columns": [
        {"name": "trade_id"         , "type": "UInt64"},
        {"name": "price"            , "type": "Float64"},
        {"name": "qty"              , "type": "Float64"},
        {"name": "quote_qty"        , "type": "Float64"},
        {"name": "time"             , "type": "Int64"},
        {"name": "is_buyer_maker"   , "type": "Bool"},
        {"name": "is_best_match"    , "type": "Bool"}
    ]
}$heredoc$;