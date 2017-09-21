#!/bin/bash

source /scripts/color.sh

if [ -e /home/techio/.assistant_away ]; then
    exit
fi

if [ "$1" == "back" ]; then
    tput setaf 3
    echo
    echo *************
    echo Welcome back!
    echo *************
    echo
    colorecho " ==> Next command: $2 <=="
    echo
    tput sgr0
else
    tput setaf 3
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
    echo Type "go_away" to get rid of the assistant. Or type "do_it" to automatically
    echo execute the next command.
    echo
    colorecho " ==> Next command: $2 <=="
    tput sgr0
fi
