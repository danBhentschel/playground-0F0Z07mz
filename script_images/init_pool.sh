#!/bin/bash

if [ ! -e /pool ]; then
    mkdir /pool
    echo "print
fix
quit"|parted ---pretend-input-tty /dev/sdb
    partprobe /dev/sdb
    echo "n



x
n
2
Disk pool
r
w
y" | fdisk /dev/sdb
    partprobe /dev/sdb
    mkfs.ext4 /dev/sdb2
    e2label /dev/sdb2 Disk-Pool-FS
echo "
/dev/sdb2 /pool ext4 defaults 0 0
"| sudo tee -a /etc/fstab >/dev/null
    mount -a
    chmod 777 /pool
fi
