#!/bin/bash

source /scripts/color.sh

if [ -e /home/techio/.assistant_away ]; then
    exit
fi

if [ "$1" == "back" ]; then
    echo -e $BLUE
    echo *************
    echo Welcome back!
    echo *************
    echo
    cmdecho "$2"
    echo
else
    echo -e $BLUE
    echo *****************************************
    echo Welcome to $1
    echo *****************************************
    echo
    echo -e Your ${COLOR}lesson assistant${BLUE} will make suggestions based on your progress.
    echo Assistant messages will look like this:
    echo
    colorecho " ==> Hello from the lesson assistant <=="
    echo
    echo -e ${BLUE}Type ${NOCOLOR}go_away${BLUE} to get rid of the assistant. Or type ${NOCOLOR}do_it${BLUE} to
    echo automatically execute the next command.
    echo
    cmdecho "$2"
fi
