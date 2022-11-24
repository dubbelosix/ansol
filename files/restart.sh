#!/bin/bash
if [ $# -eq 0 ]
  then
    python3 /mnt/snapcheck.py
fi
sudo systemctl stop sol.service
sudo pkill -9 -f solana-sys-tuner
sudo $(command -v /mnt/solana/target/release/solana-sys-tuner) --user $(whoami) > sys-tuner.log 2>&1 &
sudo systemctl start sol.service
