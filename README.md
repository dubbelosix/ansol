# ansol

### machine setting
* this process works best on latitude machines 
  * because the initial state of the machine is cleaner
  * disks are named consistently (nvme01, nvme0n2)
  * ubuntu installed (preferably ubuntu 20.04, 22.04) - this won't work with centos etc since they don't use aptitude by default
  * the login user being ubuntu helps (all the solana operations are done using the solana user that the ansible playbook creates)
  * ubuntu should be in the sudoers list
  * clean unmounted disks. if your root is on one of partitions and you pass it as an argument, this could potentially be disastrous.

* all the above are satisfied by a fresh latitude launch

* you can launch latitude machines here https://www.latitude.sh/pricing
* recommend the s3.large.x86 - it is one of the most performant nodes for staying at tip

* Specs
  * 24 cores or more
  * 512 GB ram if you want to use ramdisk/tmpfs and store the accounts db in RAM (we use 300 GB for ram disk). without tmpfs, the ram requirement can be significantly lower. ~256 GB
  * 3-4 TB (multiple disks is ok i.e. 2x 1.9TB because the ansible playbook stripes them together)

### step 1: ssh into your machine


### step 2: start a screen session
```
screen -S sol
```

### step 3:  install ansible
```
sudo apt-get install ansible -y
```

### step 4: clone the anssol repository
```
git clone https://github.com/dubbelosix/ansol.git
```

### step 5: cd into the ansol folder
```
cd ansol
```

### step 6: run the ansible command
* this command can take between 10-20 minutes based on the specs of the machine
* it takes long because it does everything necessary to start the validator (format disks, checkout the solana repo and build, download the latest snapshot etc)
```
time ansible-playbook runner.yaml --extra-vars='{"solana_version": "v1.13.5", "swap_mb":100000,"raw_disk_list":["/dev/nvme2n1","/dev/nvme1n1"],"setup_disks":true,"download_snapshot":true,"ramdisk_size":300}'
```

#### params explained
* solana_version: which version of solana do we want to run
* swap_mb: megabytes of swap. can set this to 50% of RAM or even lower. 100 GB is fine on a 512 GB RAM machine (variable value is in MB so 100000)
* raw_disk_list: the list of currently unmounted disks that will be wiped, raided, formatted with ext4 and then mounted to /mnt
* ramdisk_size: this is optional and only necessary if you want to use ramdisk for the validator - carves out a large portion of the RAM to store the accountsdb. On a 512 GB RAM instance, this can be set to 300 GB (variable value is in GB so 300)

### step 7: after ansible finishes
switch to the solana user with
```
sudo su - solana
```
### step 8: and check the validator status with
```
/mnt/solana/target/release/solana-validator --ledger /mnt/solana-ledger monitor
ledger monitor
Ledger location: /mnt/solana-ledger
⠉ Validator startup: SearchingForRpcService...
```

### Initially the monitor should just show. this will last for a few minutes and is normal 
```
⠉ Validator startup: SearchingForRpcService...
```
### after a while, the message at the terminal should change to
```
⠐ 00:08:26 | Processed Slot: 156831951 | Confirmed Slot: 156831951 | Finalized Slot: 156831917 | Full Snapshot Slot: 156813730 |
```

If you see the message above, then everything is working fine! Gratz. you have a new RPC server and you can visit the URL at http://xx.xx.xx.xx:8899/

