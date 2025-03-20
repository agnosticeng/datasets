create or replace view eth_panda_ops__xatu__mainnet__canonical_beacon_block_execution_transaction as (
    with 
        (
            select arrayMap(
                x -> toDate(x),  
                range(toInt32({from:Date}), toInt32({to:Date}))
            )
        ) as dates,

        (
            select arrayMap(
                x -> toYear(x) || '/' || toMonth(x) || '/' || toDayOfMonth(x),
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
    from s3(
        'https://data.ethpandaops.io/xatu/' || {network:String} || '/databases/default/canonical_beacon_block_execution_transaction/' || files_pattern || '.parquet',
        'Parquet',
        $heredoc$
            updated_date_time Nullable(UInt32),
            slot Nullable(UInt32),
            slot_start_date_time Nullable(UInt32),
            epoch Nullable(UInt32),
            epoch_start_date_time Nullable(UInt32),
            block_root Nullable(FixedString(66)),
            block_version Nullable(String),
            position Nullable(UInt32),
            hash Nullable(FixedString(66)),
            from Nullable(FixedString(42)),
            to Nullable(FixedString(42)),
            nonce Nullable(UInt64),
            gas_price Nullable(FixedString(16)),
            gas Nullable(UInt64),
            gas_tip_cap Nullable(FixedString(16)),
            gas_fee_cap Nullable(FixedString(16)),
            value Nullable(FixedString(16)),
            type Nullable(UInt8),
            size Nullable(UInt32),
            call_data_size Nullable(UInt32),
            blob_gas Nullable(UInt64),
            blob_gas_fee_cap Nullable(FixedString(16)),
            blob_hashes Array(Nullable(String)),
            blob_sidecars_size Nullable(UInt32),
            blob_sidecars_empty_size Nullable(UInt32),
            meta_client_name Nullable(String),
            meta_client_id Nullable(String),
            meta_client_version Nullable(String),
            meta_client_implementation Nullable(String),
            meta_client_os Nullable(String),
            meta_client_ip Nullable(FixedString(16)),
            meta_client_geo_city Nullable(String),
            meta_client_geo_country Nullable(String),
            meta_client_geo_country_code Nullable(String),
            meta_client_geo_continent_code Nullable(String),
            meta_client_geo_longitude Nullable(Float64),
            meta_client_geo_latitude Nullable(Float64),
            meta_client_geo_autonomous_system_number Nullable(UInt32),
            meta_client_geo_autonomous_system_organization Nullable(String),
            meta_network_id Nullable(Int32),
            meta_network_name Nullable(String),
            meta_consensus_version Nullable(String),
            meta_consensus_version_major Nullable(String),
            meta_consensus_version_minor Nullable(String),
            meta_consensus_version_patch Nullable(String),
            meta_consensus_implementation Nullable(String),
            meta_labels Map(String, Nullable(String))
            
        $heredoc$
    )
    settings 
        remote_filesystem_read_prefetch=false,
        glob_expansion_max_elements=10000
)
comment $comment${
    "short": "Contains execution transaction from a beacon block.",
    "url": "https://ethpandaops.io/data/xatu/schema/canonical_beacon_/",
    "usage": "select * from canonical_beacon_block_execution_transaction(network = 'mainnet', from='2022-09-06', to='2022-09-08') limit 10",
    "columns": [
        {"name": "updated_date_time", "type": "Nullable(UInt32)"},
        {"name": "slot", "type": "Nullable(UInt32)"},
        {"name": "slot_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "epoch", "type": "Nullable(UInt32)"},
        {"name": "epoch_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "block_root", "type": "Nullable(FixedString(66))"},
        {"name": "block_version", "type": "Nullable(String)"},
        {"name": "position", "type": "Nullable(UInt32)"},
        {"name": "hash", "type": "Nullable(FixedString(66))"},
        {"name": "from", "type": "Nullable(FixedString(42))"},
        {"name": "to", "type": "Nullable(FixedString(42))"},
        {"name": "nonce", "type": "Nullable(UInt64)"},
        {"name": "gas_price", "type": "Nullable(FixedString(16))"},
        {"name": "gas", "type": "Nullable(UInt64)"},
        {"name": "gas_tip_cap", "type": "Nullable(FixedString(16))"},
        {"name": "gas_fee_cap", "type": "Nullable(FixedString(16))"},
        {"name": "value", "type": "Nullable(FixedString(16))"},
        {"name": "type", "type": "Nullable(UInt8)"},
        {"name": "size", "type": "Nullable(UInt32)"},
        {"name": "call_data_size", "type": "Nullable(UInt32)"},
        {"name": "blob_gas", "type": "Nullable(UInt64)"},
        {"name": "blob_gas_fee_cap", "type": "Nullable(FixedString(16))"},
        {"name": "blob_hashes", "type": "Array(Nullable(String))"},
        {"name": "blob_sidecars_size", "type": "Nullable(UInt32)"},
        {"name": "blob_sidecars_empty_size", "type": "Nullable(UInt32)"},
        {"name": "meta_client_name", "type": "Nullable(String)"},
        {"name": "meta_client_id", "type": "Nullable(String)"},
        {"name": "meta_client_version", "type": "Nullable(String)"},
        {"name": "meta_client_implementation", "type": "Nullable(String)"},
        {"name": "meta_client_os", "type": "Nullable(String)"},
        {"name": "meta_client_ip", "type": "Nullable(FixedString(16))"},
        {"name": "meta_client_geo_city", "type": "Nullable(String)"},
        {"name": "meta_client_geo_country", "type": "Nullable(String)"},
        {"name": "meta_client_geo_country_code", "type": "Nullable(String)"},
        {"name": "meta_client_geo_continent_code", "type": "Nullable(String)"},
        {"name": "meta_client_geo_longitude", "type": "Nullable(Float64)"},
        {"name": "meta_client_geo_latitude", "type": "Nullable(Float64)"},
        {"name": "meta_client_geo_autonomous_system_number", "type": "Nullable(UInt32)"},
        {"name": "meta_client_geo_autonomous_system_organization", "type": "Nullable(String)"},
        {"name": "meta_network_id", "type": "Nullable(Int32)"},
        {"name": "meta_network_name", "type": "Nullable(String)"},
        {"name": "meta_consensus_version", "type": "Nullable(String)"},
        {"name": "meta_consensus_version_major", "type": "Nullable(String)"},
        {"name": "meta_consensus_version_minor", "type": "Nullable(String)"},
        {"name": "meta_consensus_version_patch", "type": "Nullable(String)"},
        {"name": "meta_consensus_implementation", "type": "Nullable(String)"},
        {"name": "meta_labels", "type": "Map(String, Nullable(String))"}
        
    ]
}$comment$;