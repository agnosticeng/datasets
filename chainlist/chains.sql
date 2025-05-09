create or replace view chainlist__chains as (
    select * from url('https://chainid.network/chains.json')
)
comment $comment${
    "short": "A list of metadata about chains.",
    "url": "https://chainid.network/",
    "usage": "select * from chainlist__chains limit 10"
}$comment$;