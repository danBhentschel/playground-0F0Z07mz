#!/bin/bash

if [ ! -e /pool ]; then
    mkdir /pool
    echo "print
fix
quit"|parted ---pretend-input-tty /dev/sdb
    partprobe /dev/sdb
fi
