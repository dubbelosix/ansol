#!/bin/bash
sudo systemctl stop sol.service
python3 /mnt/snapshot-finder.py --snapshot_path /mnt/solana-snapshots
sudo systemctl start sol.service