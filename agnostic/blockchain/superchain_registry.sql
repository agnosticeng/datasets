create or replace view agnostic__blockchain__superchain_registry as (
    with 
        (
            select 
                groupArray(identifier)
            from s3('https://raw.githubusercontent.com/ethereum-optimism/superchain-registry/main/chainList.json')
        ) as chains,

        configs as (
            select
                _file as file,
                JSONExtract(convert_format('TOML', 'JSON', raw_blob), 'JSON') as js
            from s3('https://raw.githubusercontent.com/ethereum-optimism/superchain-registry/main/superchain/configs/{' || arrayStringConcat(chains, ',') || '}.toml', 'RawBLOB')
        )
    select 
        file,
        js.name::String as name,
        js.public_rpc::String as public_rpc,
        js.sequencer_rpc::String as sequencer_rpc,
        js.explorer::String as explorer,
        js.superchain_level::Int32 as superchain_level,
        js.governed_by_optimism::Bool as governed_by_optimism,
        js.superchain_time::Int64 as superchain_time,
        js.data_availability_type::String as data_availability_type,
        js.chain_id::Int64 as chain_id,
        js.batch_inbox_addr::String as batch_inbox_addr,
        js.block_time::Int64 as block_time,
        js.seq_window_size::Int64 as seq_window_size,
        js.max_sequencer_drift::Int64 as max_sequencer_drift,
        js.^hardforks::String as hardforks,
        js.^optimism::String as optimism,
        js.^genesis::String as genesis,
        js.^roles::String as roles,
        js.^addresses::String as addresses
    from configs
)
comment $comment${
    "short": "Superchain.",
    "url": "https://agnostic.dev/",
    "usage": "select * from agnostic__blockchain__ethereum_mainnet__blocks limit 10"
}$comment$
settings 
    use_hive_partitioning = 1,
    allow_suspicious_low_cardinality_types = 1;
