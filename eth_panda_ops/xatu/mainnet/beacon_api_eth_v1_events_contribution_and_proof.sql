create or replace view eth_panda_ops__xatu__mainnet__beacon_api_eth_v1_events_contribution_and_proof as (
    with 
        (
            select arrayMap(
                x -> toDateTime64(x, 0, 'UTC'),
                range(toInt64({from:DateTime64(3, 'UTC')}), toInt64({to:DateTime64(3, 'UTC')}), 60*60)
            )
        ) as datetimes,

        (
            select arrayMap(
                x -> toYear(x) || '/' || toMonth(x) || '/' || toDayOfMonth(x) || '/' || toHour(x),
                datetimes
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
    from url(
        'https://data.ethpandaops.io/xatu/' || {network:String} || '/databases/default/beacon_api_eth_v1_events_contribution_and_proof/' || files_pattern || '.parquet',
        'Parquet',
        $heredoc$
            updated_date_time Nullable(UInt32),
            event_date_time Nullable(DateTime64(3, 'UTC')),
            aggregator_index Nullable(UInt32),
            contribution_slot Nullable(UInt32),
            contribution_slot_start_date_time Nullable(UInt32),
            contribution_propagation_slot_start_diff Nullable(UInt32),
            contribution_beacon_block_root Nullable(FixedString(66)),
            contribution_subcommittee_index Nullable(String),
            contribution_aggregation_bits Nullable(String),
            contribution_signature Nullable(String),
            contribution_epoch Nullable(UInt32),
            contribution_epoch_start_date_time Nullable(UInt32),
            selection_proof Nullable(String),
            signature Nullable(String),
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
comment $heredoc${
    "short": "Contains beacon API eventstream “contribution and proof” data from each sentry client attached to a beacon node.",
    "url": "https://ethpandaops.io/data/xatu/schema/beacon_api_/",
    "usage": "select * from eth_panda_ops__xatu__mainnet__beacon_api_eth_v1_events_contribution_and_proof limit 10",
    "columns": [
        {"name": "updated_date_time", "type": "Nullable(UInt32)"},
        {"name": "event_date_time", "type": "Nullable(DateTime64(3, 'UTC'))"},
        {"name": "aggregator_index", "type": "Nullable(UInt32)"},
        {"name": "contribution_slot", "type": "Nullable(UInt32)"},
        {"name": "contribution_slot_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "contribution_propagation_slot_start_diff", "type": "Nullable(UInt32)"},
        {"name": "contribution_beacon_block_root", "type": "Nullable(FixedString(66))"},
        {"name": "contribution_subcommittee_index", "type": "Nullable(String)"},
        {"name": "contribution_aggregation_bits", "type": "Nullable(String)"},
        {"name": "contribution_signature", "type": "Nullable(String)"},
        {"name": "contribution_epoch", "type": "Nullable(UInt32)"},
        {"name": "contribution_epoch_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "selection_proof", "type": "Nullable(String)"},
        {"name": "signature", "type": "Nullable(String)"},
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
}$heredoc$;