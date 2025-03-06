create or replace view eth_panda_ops__xatu__mainnet__canonical_beacon_elaborated_attestation as (
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
        'https://data.ethpandaops.io/xatu/' || {network:String} || '/databases/default/canonical_beacon_elaborated_attestation/' || files_pattern || '.parquet',
        'Parquet',
        $heredoc$
            updated_date_time Nullable(UInt32),
            block_slot Nullable(UInt32),
            block_slot_start_date_time Nullable(UInt32),
            block_epoch Nullable(UInt32),
            block_epoch_start_date_time Nullable(UInt32),
            position_in_block Nullable(UInt32),
            block_root Nullable(FixedString(66)),
            validators Array(Nullable(UInt32)),
            committee_index Nullable(String),
            beacon_block_root Nullable(FixedString(66)),
            slot Nullable(UInt32),
            slot_start_date_time Nullable(UInt32),
            epoch Nullable(UInt32),
            epoch_start_date_time Nullable(UInt32),
            source_epoch Nullable(UInt32),
            source_epoch_start_date_time Nullable(UInt32),
            source_root Nullable(FixedString(66)),
            target_epoch Nullable(UInt32),
            target_epoch_start_date_time Nullable(UInt32),
            target_root Nullable(FixedString(66)),
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
    "short": "Contains elaborated attestations from beacon blocks.",
    "url": "https://ethpandaops.io/data/xatu/schema/canonical_beacon_/",
    "usage": "select * from eth_panda_ops__xatu__mainnet__canonical_beacon_elaborated_attestation limit 10",
    "columns": [
        {"name": "updated_date_time", "type": "Nullable(UInt32)"},
        {"name": "block_slot", "type": "Nullable(UInt32)"},
        {"name": "block_slot_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "block_epoch", "type": "Nullable(UInt32)"},
        {"name": "block_epoch_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "position_in_block", "type": "Nullable(UInt32)"},
        {"name": "block_root", "type": "Nullable(FixedString(66))"},
        {"name": "validators", "type": "Array(Nullable(UInt32))"},
        {"name": "committee_index", "type": "Nullable(String)"},
        {"name": "beacon_block_root", "type": "Nullable(FixedString(66))"},
        {"name": "slot", "type": "Nullable(UInt32)"},
        {"name": "slot_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "epoch", "type": "Nullable(UInt32)"},
        {"name": "epoch_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "source_epoch", "type": "Nullable(UInt32)"},
        {"name": "source_epoch_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "source_root", "type": "Nullable(FixedString(66))"},
        {"name": "target_epoch", "type": "Nullable(UInt32)"},
        {"name": "target_epoch_start_date_time", "type": "Nullable(UInt32)"},
        {"name": "target_root", "type": "Nullable(FixedString(66))"},
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