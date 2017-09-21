#!/bin/bash

source /scripts/color.sh

if [ -e /home/techio/.assistant_away ]; then
    exit
fi

if [ "$1" == "back" ]; then
    echo
    echo *************
    echo Welcome back!
    echo *************
    echo
    cmdecho "$2"
    echo
else
    echo
    echo *****************************************
    echo Welcome to $1
    echo *****************************************
    echo
    echo -e Your ${COLOR}lesson assistant${NOCOLOR} will make suggestions based on your progress.
    echo Assistant messages will look like this:
    echo
    colorecho " ==> Hello from the lesson assistant <=="
    echo
    echo Type ${GRAY}go_away${NOCOLOR} to get rid of the assistant. Or type ${GRAY}do_it${NOCOLOR} to
    echo automatically execute the next command.
    echo
    cmdecho "$2"
fi
