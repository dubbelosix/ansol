# ansol

```
sudo apt-get install ansible -y

time ansible-playbook runner.yaml -vv --extra-vars='{"solana_version": "v1.13.4", "swap_mb":200000,"raw_disk_list":["/dev/nvme0n1","/dev/nvme1n1"],"setup_disks":true,"download_snapshot":true,"ramdisk_size":300}'
```
