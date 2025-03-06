create or replace view eth_panda_ops__xatu__mainnet__canonical_beacon_block as (
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
        'https://data.ethpandaops.io/xatu/' || {network:String} || '/databases/default/canonical_beacon_block/' || files_pattern || '.parquet',
        'Parquet',
        $heredoc$
            updated_date_time Nullable(UInt32),
            slot Nullable(UInt32),
            slot_start_date_time Nullable(UInt32),
            epoch Nullable(UInt32),
            epoch_start_date_time Nullable(UInt32),
            block_root Nullable(FixedString(66)),
            block_version Nullable(String),
            block_total_bytes Nullable(UInt32),
            block_total_bytes_compressed Nullable(UInt32),
            parent_root Nullable(FixedString(66)),
            state_root Nullable(FixedString(66)),
            proposer_index Nullable(UInt32),
            eth1_data_block_hash Nullable(FixedString(66)),
            eth1_data_deposit_root Nullable(FixedString(66)),
            execution_payload_block_hash Nullable(FixedString(66)),
            execution_payload_block_number Nullable(UInt32),
            execution_payload_fee_recipient Nullable(String),
            execution_payload_base_fee_per_gas Nullable(FixedString(16)),
            execution_payload_blob_gas_used Nullable(UInt64),
            execution_payload_excess_blob_gas Nullable(UInt64),
            execution_payload_gas_limit Nullable(UInt64),
            execution_payload_gas_used Nullable(UInt64),
            execution_payload_state_root Nullable(FixedString(66)),
            execution_payload_parent_hash Nullable(FixedString(66)),
            execution_payload_transactions_count Nullable(UInt32),
            execution_payload_transactions_total_bytes Nullable(UInt32),
            execution_payload_transactions_total_bytes_compressed Nullable(UInt32),
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
    "short": "Contains beacon block from a beacon node.",
    "url": "https://ethpandaops.io/data/xatu/schema/canonical_beacon_/",
    "usage": "select * from eth_panda_ops__xatu__mainnet__canonical_beacon_block limit 10",
    "columns": [
        {"name": "updated_date_time", "type": "Nullable(UInt32)"},
        {"name": "slot", "type": "Nullable(UInt32)"},
        {"name": "slot_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "epoch", "type": "Nullable(UInt32)"},
        {"name": "epoch_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "block_root", "type": "Nullable(FixedString(66))"},
        {"name": "block_version", "type": "Nullable(String)"},
        {"name": "block_total_bytes", "type": "Nullable(UInt32)"},
        {"name": "block_total_bytes_compressed", "type": "Nullable(UInt32)"},
        {"name": "parent_root", "type": "Nullable(FixedString(66))"},
        {"name": "state_root", "type": "Nullable(FixedString(66))"},
        {"name": "proposer_index", "type": "Nullable(UInt32)"},
        {"name": "eth1_data_block_hash", "type": "Nullable(FixedString(66))"},
        {"name": "eth1_data_deposit_root", "type": "Nullable(FixedString(66))"},
        {"name": "execution_payload_block_hash", "type": "Nullable(FixedString(66))"},
        {"name": "execution_payload_block_number", "type": "Nullable(UInt32)"},
        {"name": "execution_payload_fee_recipient", "type": "Nullable(String)"},
        {"name": "execution_payload_base_fee_per_gas", "type": "Nullable(FixedString(16))"},
        {"name": "execution_payload_blob_gas_used", "type": "Nullable(UInt64)"},
        {"name": "execution_payload_excess_blob_gas", "type": "Nullable(UInt64)"},
        {"name": "execution_payload_gas_limit", "type": "Nullable(UInt64)"},
        {"name": "execution_payload_gas_used", "type": "Nullable(UInt64)"},
        {"name": "execution_payload_state_root", "type": "Nullable(FixedString(66))"},
        {"name": "execution_payload_parent_hash", "type": "Nullable(FixedString(66))"},
        {"name": "execution_payload_transactions_count", "type": "Nullable(UInt32)"},
        {"name": "execution_payload_transactions_total_bytes", "type": "Nullable(UInt32)"},
        {"name": "execution_payload_transactions_total_bytes_compressed", "type": "Nullable(UInt32)"},
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