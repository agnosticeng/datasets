
This repository contains agnostic datasets that can be loaded into various database systems. Those datasets are loaded into the https://agx.app instance.



## Datasets List

The following blockchain dataset views are available:

[agnostic/blockchain/ethereum_mainnet.sql](agnostic/blockchain/ethereum_mainnet.sql)

- `agnostic__blockchain__ethereum_mainnet__blocks` - Block level data
- `agnostic__blockchain__ethereum_mainnet__logs` - Event log data
- `agnostic__blockchain__ethereum_mainnet__transactions` - Transaction data
- `agnostic__blockchain__ethereum_mainnet__traces` - Transaction trace data
- `agnostic__blockchain__ethereum_mainnet__decoded_logs` - Decoded event log data


### Prerequisites

- A running instance of your preferred database (agx, Clickhouse, etc.)
- Ability to execute SQL commands on your database

### Usage with agx

1. Open agx (native)
2. Drag and drop the dataset file into the agx interface
3. Run the query

## Contributing

Please feel free to submit pull requests to add more datasets or improve existing ones.

## License

This project is licensed under the MIT License - see the LICENSE file for details
