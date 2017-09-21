#!/bin/bash

YELLOW='\033[1;33m'
NOCOLOR='\033[0m'

echo
echo Preparing to start VM...
echo
echo

ln -s /vmlinuz-4.4.0-89-generic
ln -s /initrd.img-4.4.0-89-generic
ln -s /ubuntu.img
ln -s lesson${1}.img scripts.img
if [ -e /project/target/prepare_vm.sh ]; then
    /project/target/prepare_vm.sh ${1}
fi

echo -ne ${YELLOW}
echo You might want to take some time now
echo to preread the instructions below
echo and to resize the terminal window
echo -ne ${NOCOLOR}
echo

/start_vm.sh
