create or replace dictionary agnostic__blockchain__evm_abi_decoding (
    selector String,
    fullsigs Array(String)
)
primary key selector
source(http(url 'https://pub-c95b23ccaa6b4a92a8a1411feca96564.r2.dev/sourcify/evm_abi_decoding.parquet' format 'Parquet'))
lifetime(min 3600 max 7200)
layout(hashed())