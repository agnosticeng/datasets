-- Doc: https://github.com/binance/binance-public-data/

create or replace view binance__spot__daily_trades as
with 
    (
        select arrayStringConcat(
            arrayMap(
                x -> toDate(x),  
                range(toInt32({from:Date}), toInt32({to:Date}))
            ),
            ','
        )
    ) as dates

select 
    trade_id,
    price,
    qty,
    quote_qty,
    fromUnixTimestamp(toInt64(time/1000000)) as time,
    is_buyer_maker,
    is_best_match
from s3(
    'https://data.binance.vision/data/spot/daily/trades/' || {pair:String} || '/' || {pair:String} || '-trades-{' || dates || '}.zip :: *.csv',
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