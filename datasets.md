## Datasets List

The following tables ands views are available:


[okx](okx)


- `okx__daily_trades` - Daily trades of spot pairs on the OKX exchange.


[sourcify](sourcify)


- `sourcify__verified_contracts` - Verified contracts from the Sourcify repository.

- `sourcify__sourcify_matches` - Sourcify matches from the Sourcify repository.

- `sourcify__contracts` - Contracts from the Sourcify repository.

- `sourcify__code` - Contracts code from the Sourcify repository.

- `sourcify__sources` - Contract source files from the Sourcify repository.

- `sourcify__compiled_contracts` - Compiled contracts from the Sourcify repository.

- `sourcify__contract_deployments` - Contract deployments from the Sourcify repository.

- `sourcify__compiled_contracts_sources` - Compiled contract sources from the Sourcify repository.


[binance/spot](binance/spot)


- `binance__spot__daily_agg_trades` - Daily aggregate trades of spot pairs on the Binance exchange.

- `binance__spot__daily_klines` - Daily klines of spot pairs on the Binance exchange.

- `binance__spot__daily_trades` - Daily trades of spot pairs on the Binance exchange.


[agnostic/blockchain](agnostic/blockchain)


- `agnostic__blockchain__evm_abi_decoding` - EVM selector to list of fullsig dictionnary.


[agnostic/blockchain/ethereum_mainnet](agnostic/blockchain/ethereum_mainnet)


- `agnostic__blockchain__ethereum_mainnet__decoded_logs` - Decoded event log data.

- `agnostic__blockchain__ethereum_mainnet__blocks` - Block level data.

- `agnostic__blockchain__ethereum_mainnet__traces` - Transaction trace data.

- `agnostic__blockchain__ethereum_mainnet__transactions` - Transaction data

- `agnostic__blockchain__ethereum_mainnet__logs` - Event log data.


[aws/public_blockchain_data/btc](aws/public_blockchain_data/btc)


- `aws__public_blockchain_data__btc__blocks` - 

- `aws__public_blockchain_data__btc__transactions` - 


[aws/public_blockchain_data/ethereum](aws/public_blockchain_data/ethereum)


- `aws__public_blockchain_data__ethereum__token_transfers` - 

- `aws__public_blockchain_data__ethereum__contracts` - 

- `aws__public_blockchain_data__ethereum__blocks` - 

- `aws__public_blockchain_data__ethereum__traces` - 

- `aws__public_blockchain_data__ethereum__transactions` - 

- `aws__public_blockchain_data__ethereum__logs` - 


[aws/public_blockchain_data/sonarx/xrp](aws/public_blockchain_data/sonarx/xrp)


- `aws__public_blockchain_data__sonarx__xrp__transactions_failed` - 

- `aws__public_blockchain_data__sonarx__xrp__blocks` - 

- `aws__public_blockchain_data__sonarx__xrp__transactions` - 

- `aws__public_blockchain_data__sonarx__xrp__transfers` - 

- `aws__public_blockchain_data__sonarx__xrp__affected_nodes` - 


[aws/public_blockchain_data/sonarx/arbitrum](aws/public_blockchain_data/sonarx/arbitrum)


- `aws__public_blockchain_data__sonarx__arbitrum__transactions_failed` - 

- `aws__public_blockchain_data__sonarx__arbitrum__receipts` - 

- `aws__public_blockchain_data__sonarx__arbitrum__blocks` - 

- `aws__public_blockchain_data__sonarx__arbitrum__traces` - 

- `aws__public_blockchain_data__sonarx__arbitrum__transactions` - 

- `aws__public_blockchain_data__sonarx__arbitrum__logs` - 

- `aws__public_blockchain_data__sonarx__arbitrum__transfers` - 

- `aws__public_blockchain_data__sonarx__arbitrum__approvals` - 


[aws/public_blockchain_data/sonarx/aptos](aws/public_blockchain_data/sonarx/aptos)


- `aws__public_blockchain_data__sonarx__aptos__withdrawals` - 

- `aws__public_blockchain_data__sonarx__aptos__changes` - 

- `aws__public_blockchain_data__sonarx__aptos__transactions_failed` - 

- `aws__public_blockchain_data__sonarx__aptos__deposits` - 

- `aws__public_blockchain_data__sonarx__aptos__blocks` - 

- `aws__public_blockchain_data__sonarx__aptos__transactions` - 

- `aws__public_blockchain_data__sonarx__aptos__transfers` - 

- `aws__public_blockchain_data__sonarx__aptos__events` - 


[aws/public_blockchain_data/sonarx/provenance](aws/public_blockchain_data/sonarx/provenance)


- `aws__public_blockchain_data__sonarx__provenance__block_results` - 

- `aws__public_blockchain_data__sonarx__provenance__transactions_failed` - 

- `aws__public_blockchain_data__sonarx__provenance__begin_block_events` - 

- `aws__public_blockchain_data__sonarx__provenance__validator_updates` - 

- `aws__public_blockchain_data__sonarx__provenance__signatures` - 

- `aws__public_blockchain_data__sonarx__provenance__blocks` - 

- `aws__public_blockchain_data__sonarx__provenance__end_block_events` - 

- `aws__public_blockchain_data__sonarx__provenance__transactions` - 

- `aws__public_blockchain_data__sonarx__provenance__finalize_block_events` - 

- `aws__public_blockchain_data__sonarx__provenance__logs` - 

- `aws__public_blockchain_data__sonarx__provenance__transfers` - 

- `aws__public_blockchain_data__sonarx__provenance__events` - 


[aws/public_blockchain_data/sonarx/base](aws/public_blockchain_data/sonarx/base)


- `aws__public_blockchain_data__sonarx__base__transactions_failed` - 

- `aws__public_blockchain_data__sonarx__base__receipts` - 

- `aws__public_blockchain_data__sonarx__base__blocks` - 

- `aws__public_blockchain_data__sonarx__base__traces` - 

- `aws__public_blockchain_data__sonarx__base__transactions` - 

- `aws__public_blockchain_data__sonarx__base__logs` - 

- `aws__public_blockchain_data__sonarx__base__transfers` - 

- `aws__public_blockchain_data__sonarx__base__approvals` - 


[paradigm/data_portal](paradigm/data_portal)


- `paradigm__data_portal__ethereum_contracts` - All historical contract deployments.

- `paradigm__data_portal__ethereum_slots` - All slots of each contract, including historical usage metadata.

- `paradigm__data_portal__ethereum_native_transfers` - All native transfers in similar format to ERC20 Transfers (excluding tx fees).


[eth_panda_ops/xatu/mainnet](eth_panda_ops/xatu/mainnet)


- `eth_panda_ops__xatu__mainnet__mempool_transaction` - Each row represents a transaction that was seen in the mempool by a sentry client. Sentries can report the same transaction multiple times if it has been long enough since the last report.

- `eth_panda_ops__xatu__mainnet__canonical_beacon_block` - Contains beacon block from a beacon node.

- `eth_panda_ops__xatu__mainnet__beacon_api_eth_v1_events_attestation` - Contains beacon API eventstream “attestation” data from each sentry client attached to a beacon node.

- `eth_panda_ops__xatu__mainnet__beacon_api_eth_v3_validator_block` - Contains beacon API /eth/v3/validator/blocks/{slot} data from each sentry client attached to a beacon node.

- `eth_panda_ops__xatu__mainnet__canonical_beacon_proposer_duty` - Contains a proposer duty from a beacon block.

- `eth_panda_ops__xatu__mainnet__beacon_api_eth_v2_beacon_block` - Contains beacon API /eth/v2/beacon/blocks/{block_id} data from each sentry client attached to a beacon node.

- `eth_panda_ops__xatu__mainnet__beacon_api_eth_v1_events_finalized_checkpoint` - Contains beacon API eventstream “finalized checkpoint” data from each sentry client attached to a beacon node.

- `eth_panda_ops__xatu__mainnet__beacon_api_eth_v1_events_voluntary_exit` - Contains beacon API eventstream “voluntary exit” data from each sentry client attached to a beacon node.

- `eth_panda_ops__xatu__mainnet__canonical_beacon_block_proposer_slashing` - Contains proposer slashing from a beacon block.

- `eth_panda_ops__xatu__mainnet__mev_relay_validator_registration` - Contains MEV relay validator registrations data.

- `eth_panda_ops__xatu__mainnet__beacon_api_eth_v1_events_chain_reorg` - Contains beacon API eventstream “chain reorg” data from each sentry client attached to a beacon node.

- `eth_panda_ops__xatu__mainnet__canonical_beacon_block_attester_slashing` - Contains attester slashing from a beacon block.

- `eth_panda_ops__xatu__mainnet__mev_relay_proposer_payload_delivered` - Contains MEV relay proposer payload delivered data.

- `eth_panda_ops__xatu__mainnet__canonical_beacon_block_voluntary_exit` - Contains a voluntary exit from a beacon block.

- `eth_panda_ops__xatu__mainnet__beacon_api_eth_v1_proposer_duty` - Contains a proposer duty from a beacon block.

- `eth_panda_ops__xatu__mainnet__canonical_beacon_block_withdrawal` - Contains a withdrawal from a beacon block.

- `eth_panda_ops__xatu__mainnet__beacon_api_eth_v1_events_block` - Contains beacon API eventstream “block” data from each sentry client attached to a beacon node.

- `eth_panda_ops__xatu__mainnet__libp2p_gossipsub_beacon_block` - Table for libp2p gossipsub beacon block data.

- `eth_panda_ops__xatu__mainnet__canonical_beacon_block_deposit` - Contains a deposit from a beacon block.

- `eth_panda_ops__xatu__mainnet__canonical_beacon_blob_sidecar` - Contains a blob sidecar from a beacon block.

- `eth_panda_ops__xatu__mainnet__canonical_beacon_elaborated_attestation` - Contains elaborated attestations from beacon blocks.

- `eth_panda_ops__xatu__mainnet__mev_relay_bid_trace` - Contains MEV relay block bids data.

- `eth_panda_ops__xatu__mainnet__libp2p_gossipsub_beacon_attestation` - Table for libp2p gossipsub beacon attestation data.

- `eth_panda_ops__xatu__mainnet__canonical_beacon_committee` - Contains canonical beacon API /eth/v1/beacon/committees data.

- `eth_panda_ops__xatu__mainnet__canonical_beacon_block_bls_to_execution_change` - Contains bls to execution change from a beacon block.

- `eth_panda_ops__xatu__mainnet__beacon_api_eth_v1_events_head` - Contains beacon API eventstream “head” data from each sentry client attached to a beacon node.

- `eth_panda_ops__xatu__mainnet__libp2p_gossipsub_blob_sidecar` - Table for libp2p gossipsub blob sidecar data.

- `eth_panda_ops__xatu__mainnet__beacon_api_eth_v1_events_blob_sidecar` - Contains beacon API eventstream “blob_sidecar” data from each sentry client attached to a beacon node.

- `eth_panda_ops__xatu__mainnet__canonical_beacon_block_execution_transaction` - Contains execution transaction from a beacon block.

- `eth_panda_ops__xatu__mainnet__beacon_api_eth_v1_validator_attestation_data` - Contains beacon API validator attestation data from each sentry client attached to a beacon node.

- `eth_panda_ops__xatu__mainnet__canonical_beacon_validators` - Contains a validator state for an epoch.

- `eth_panda_ops__xatu__mainnet__beacon_api_eth_v1_events_contribution_and_proof` - Contains beacon API eventstream “contribution and proof” data from each sentry client attached to a beacon node.

- `eth_panda_ops__xatu__mainnet__beacon_api_eth_v1_beacon_committee` - Contains beacon API /eth/v1/beacon/states/{state_id}/committees data from each sentry client attached to a beacon node.


[flashbots/mempool_dumpster](flashbots/mempool_dumpster)


- `flashbots__mempool_dumpster__ethereum_mainnet` - Dump of all mempool transactions by Flashbots.

