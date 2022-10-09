#!/bin/bash
python3 /mnt/snapcheck.py
sudo systemctl stop sol.service
sudo pkill -9 -f solana-sys-tuner
sudo $(command -v solana-sys-tuner) --user $(whoami) > sys-tuner.log 2>&1 &
sudo systemctl start sol.service
