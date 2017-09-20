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
    mount /dev/sdb2 /pool
fi
