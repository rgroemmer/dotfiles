# K3S

## Bootstrap

To Bootstrap initialy stop `k3s` & initialize, wait 5min.

```bash
sudo systemctl stop k3s
sudo k3s server --cluster-init
```

## ZFS Configuration

ZFS pool spreads over four SSDs, and is manually created with some fine-tune.

```bash
# ⚠️  This is disruptive!
sudo zpool create -f \
    -O encryption=on \
    -O keyformat=passphrase \
    -O keylocation=prompt \
    -O compression=lz4 \
    -O atime=off \
    -O mountpoint=none \
    -O xattr=sa \
    -O acltype=posixacl \
    -o ashift=12 \
    kubex-main \
    raidz2 /dev/sda /dev/sdb /dev/sdc /dev/sdd
```
