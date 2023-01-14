#!/bin/bash
export SOLANA_METRICS_CONFIG="host=https://metrics.solana.com:8086,db=mainnet-beta,u=mainnet-beta_write,p=password"
exec /mnt/solana/target/release/solana-validator --identity /home/solana/rpc_node.json \
--full-rpc-api \
--rpc-port 8899 \
--entrypoint entrypoint.mainnet-beta.solana.com:8001 \
--limit-ledger-size \
--log /mnt/logs/solana-validator.log \
--accounts /mnt/solana-accounts \
--ledger /mnt/solana-ledger \
--snapshots /mnt/solana-snapshots \
--no-snapshot-fetch \
--known-validator 7Np41oeYqPefeNQEHSv1UDhYrehxin3NStELsSKCT4K2 \
--known-validator GdnSyH3YtwcxFvQrVVJMm1JhTS4QVX7MFsX56uJLUfiZ \
--known-validator DE1bawNcRJB9rVm3buyMVfr8mBEoyyu73NBovf2oXJsJ \
--known-validator CakcnaRDHka2gXyfbEd2d3xsvkJkqsLw2akB3zsN1D2S