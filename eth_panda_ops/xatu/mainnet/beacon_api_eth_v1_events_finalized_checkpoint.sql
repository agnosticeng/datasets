create or replace view eth_panda_ops__xatu__mainnet__beacon_api_eth_v1_events_finalized_checkpoint as (
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
    from s3(
        'https://data.ethpandaops.io/xatu/' || {network:String} || '/databases/default/beacon_api_eth_v1_events_finalized_checkpoint/' || files_pattern || '.parquet',
        'Parquet',
        $heredoc$
            updated_date_time Nullable(UInt32),
            event_date_time Nullable(DateTime64(3, 'UTC')),
            block Nullable(FixedString(66)),
            state Nullable(FixedString(66)),
            epoch Nullable(UInt32),
            epoch_start_date_time Nullable(UInt32),
            execution_optimistic Nullable(Bool),
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
    "short": "Contains beacon API eventstream “finalized checkpoint” data from each sentry client attached to a beacon node.",
    "url": "https://ethpandaops.io/data/xatu/schema/beacon_api_/",
    "usage": "select * from eth_panda_ops__xatu__mainnet__beacon_api_eth_v1_events_finalized_checkpoint limit 10",
    "columns": [
        {"name": "updated_date_time", "type": "Nullable(UInt32)"},
        {"name": "event_date_time", "type": "Nullable(DateTime64(3, 'UTC'))"},
        {"name": "block", "type": "Nullable(FixedString(66))"},
        {"name": "state", "type": "Nullable(FixedString(66))"},
        {"name": "epoch", "type": "Nullable(UInt32)"},
        {"name": "epoch_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "execution_optimistic", "type": "Nullable(Bool)"},
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