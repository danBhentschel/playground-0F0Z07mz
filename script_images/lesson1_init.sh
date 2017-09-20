#!/bin/bash

if [ ! -e /pool ]; then
    apt install gdisk
    mkdir /pool
    chmod 777 /pool
    echo "w
y
y" | gdisk /dev/sdb
    partprobe /dev/sdb
    echo "n



w
y" | fdisk /dev/sdb
    partprobe /dev/sdb
    mkefs.ext4 /dev/sdb2
    mount /dev/sdb2 /pool
fi
