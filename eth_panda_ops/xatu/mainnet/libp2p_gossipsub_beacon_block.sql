create or replace view eth_panda_ops__xatu__mainnet__libp2p_gossipsub_beacon_block as (
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
        'https://data.ethpandaops.io/xatu/' || {network:String} || '/databases/default/libp2p_gossipsub_beacon_block/' || files_pattern || '.parquet',
        'Parquet',
        $heredoc$
            updated_date_time Nullable(UInt32),
            version Nullable(UInt32),
            event_date_time Nullable(DateTime64(3, 'UTC')),
            slot Nullable(UInt32),
            slot_start_date_time Nullable(UInt32),
            epoch Nullable(UInt32),
            epoch_start_date_time Nullable(UInt32),
            wallclock_slot Nullable(UInt32),
            wallclock_slot_start_date_time Nullable(UInt32),
            wallclock_epoch Nullable(UInt32),
            wallclock_epoch_start_date_time Nullable(UInt32),
            propagation_slot_start_diff Nullable(UInt32),
            block Nullable(FixedString(66)),
            proposer_index Nullable(UInt32),
            peer_id_unique_key Nullable(Int64),
            message_id Nullable(String),
            message_size Nullable(UInt32),
            topic_layer Nullable(String),
            topic_fork_digest_value Nullable(String),
            topic_name Nullable(String),
            topic_encoding Nullable(String),
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
            meta_network_name Nullable(String)
            
        $heredoc$
    )
    settings 
        remote_filesystem_read_prefetch=false,
        glob_expansion_max_elements=10000
)
comment $comment${
    "short": "Table for libp2p gossipsub beacon block data.",
    "url": "https://ethpandaops.io/data/xatu/schema/libp2p_/",
    "usage": "select * from libp2p_gossipsub_beacon_block(network = 'mainnet', from='2024-04-26', to='2024-04-28') limit 10",
    "columns": [
        {"name": "updated_date_time", "type": "Nullable(UInt32)"},
        {"name": "version", "type": "Nullable(UInt32)"},
        {"name": "event_date_time", "type": "Nullable(DateTime64(3, 'UTC'))"},
        {"name": "slot", "type": "Nullable(UInt32)"},
        {"name": "slot_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "epoch", "type": "Nullable(UInt32)"},
        {"name": "epoch_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "wallclock_slot", "type": "Nullable(UInt32)"},
        {"name": "wallclock_slot_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "wallclock_epoch", "type": "Nullable(UInt32)"},
        {"name": "wallclock_epoch_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "propagation_slot_start_diff", "type": "Nullable(UInt32)"},
        {"name": "block", "type": "Nullable(FixedString(66))"},
        {"name": "proposer_index", "type": "Nullable(UInt32)"},
        {"name": "peer_id_unique_key", "type": "Nullable(Int64)"},
        {"name": "message_id", "type": "Nullable(String)"},
        {"name": "message_size", "type": "Nullable(UInt32)"},
        {"name": "topic_layer", "type": "Nullable(String)"},
        {"name": "topic_fork_digest_value", "type": "Nullable(String)"},
        {"name": "topic_name", "type": "Nullable(String)"},
        {"name": "topic_encoding", "type": "Nullable(String)"},
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
        {"name": "meta_network_name", "type": "Nullable(String)"}
        
    ]
}$comment$;