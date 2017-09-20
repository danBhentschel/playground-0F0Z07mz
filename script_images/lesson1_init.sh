#!/bin/bash

if [ ! -e /pool ]; then
    mkdir /pool
    chmod 777 /pool
    echo "print
fix
quit"|parted ---pretend-input-tty /dev/sdb
    partprobe /dev/sdb
    echo "n



w
y" | fdisk /dev/sdb
    partprobe /dev/sdb
    mkfs.ext4 /dev/sdb2
echo "
/dev/sdb2 /pool ext4 defaults 0 0
"| sudo tee -a /etc/fstab >/dev/null
    mount -a
fi
