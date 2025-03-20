create or replace view eth_panda_ops__xatu__mainnet__mev_relay_bid_trace as (
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
        'https://data.ethpandaops.io/xatu/' || {network:String} || '/databases/default/mev_relay_bid_trace/' || files_pattern || '.parquet',
        'Parquet',
        $heredoc$
            updated_date_time Nullable(UInt32),
            event_date_time Nullable(DateTime64(3, 'UTC')),
            slot Nullable(UInt32),
            slot_start_date_time Nullable(UInt32),
            epoch Nullable(UInt32),
            epoch_start_date_time Nullable(UInt32),
            wallclock_request_slot Nullable(UInt32),
            wallclock_request_slot_start_date_time Nullable(UInt32),
            wallclock_request_epoch Nullable(UInt32),
            wallclock_request_epoch_start_date_time Nullable(UInt32),
            requested_at_slot_time Nullable(UInt32),
            response_at_slot_time Nullable(UInt32),
            relay_name Nullable(String),
            parent_hash Nullable(FixedString(66)),
            block_number Nullable(UInt64),
            block_hash Nullable(FixedString(66)),
            builder_pubkey Nullable(String),
            proposer_pubkey Nullable(String),
            proposer_fee_recipient Nullable(FixedString(42)),
            gas_limit Nullable(UInt64),
            gas_used Nullable(UInt64),
            value Nullable(FixedString(32)),
            num_tx Nullable(UInt32),
            timestamp Nullable(Int64),
            timestamp_ms Nullable(Int64),
            optimistic_submission Nullable(Bool),
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
            meta_network_name Nullable(String),
            meta_labels Map(String, Nullable(String))
            
        $heredoc$
    )
    settings 
        remote_filesystem_read_prefetch=false,
        glob_expansion_max_elements=10000
)
comment $comment${
    "short": "Contains MEV relay block bids data.",
    "url": "https://ethpandaops.io/data/xatu/schema/mev_relay_/",
    "usage": "select * from mev_relay_bid_trace(network = 'mainnet', from='2024-09-16', to='2024-09-18') limit 10",
    "columns": [
        {"name": "updated_date_time", "type": "Nullable(UInt32)"},
        {"name": "event_date_time", "type": "Nullable(DateTime64(3, 'UTC'))"},
        {"name": "slot", "type": "Nullable(UInt32)"},
        {"name": "slot_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "epoch", "type": "Nullable(UInt32)"},
        {"name": "epoch_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "wallclock_request_slot", "type": "Nullable(UInt32)"},
        {"name": "wallclock_request_slot_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "wallclock_request_epoch", "type": "Nullable(UInt32)"},
        {"name": "wallclock_request_epoch_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "requested_at_slot_time", "type": "Nullable(UInt32)"},
        {"name": "response_at_slot_time", "type": "Nullable(UInt32)"},
        {"name": "relay_name", "type": "Nullable(String)"},
        {"name": "parent_hash", "type": "Nullable(FixedString(66))"},
        {"name": "block_number", "type": "Nullable(UInt64)"},
        {"name": "block_hash", "type": "Nullable(FixedString(66))"},
        {"name": "builder_pubkey", "type": "Nullable(String)"},
        {"name": "proposer_pubkey", "type": "Nullable(String)"},
        {"name": "proposer_fee_recipient", "type": "Nullable(FixedString(42))"},
        {"name": "gas_limit", "type": "Nullable(UInt64)"},
        {"name": "gas_used", "type": "Nullable(UInt64)"},
        {"name": "value", "type": "Nullable(FixedString(32))"},
        {"name": "num_tx", "type": "Nullable(UInt32)"},
        {"name": "timestamp", "type": "Nullable(Int64)"},
        {"name": "timestamp_ms", "type": "Nullable(Int64)"},
        {"name": "optimistic_submission", "type": "Nullable(Bool)"},
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
        {"name": "meta_network_name", "type": "Nullable(String)"},
        {"name": "meta_labels", "type": "Map(String, Nullable(String))"}
        
    ]
}$comment$;