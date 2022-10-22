# ansol

### install ansible
```
sudo apt-get install ansible -y
```

### ansible command
```
time ansible-playbook runner.yaml --extra-vars='{"solana_version": "v1.13.4", "swap_mb":100000,"raw_disk_list":["/dev/nvme0n1","/dev/nvme1n1"],"setup_disks":true,"download_snapshot":true,"ramdisk_size":300}'
```

### params explained
* solana_version: which version of solana do we want to run
* swap_mb: megabytes of swap. can set this to 50% of RAM or even lower. 100 GB is fine on a 512 GB RAM machine (variable value is in MB so 100000)
* raw_disk_list: the list of currently unmounted disks that will be wiped, raided, formatted with ext4 and then mounted to /mnt
* ramdisk_size: this is optional and only necessary if you want to use ramdisk for the validator - carves out a large portion of the RAM to store the accountsdb. On a 512 GB RAM instance, this can be set to 300 GB (variable value is in GB so 300)
