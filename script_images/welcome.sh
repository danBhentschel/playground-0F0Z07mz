#!/bin/bash

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
    echo " ==> Next command: $2 <=="
    echo
    tput sgr0
else
    tput setaf 3
    echo
    echo *****************************************
    echo Welcome to $1
    echo *****************************************
    echo
    echo Your lesson assistant will make suggestions based on your progress.
    echo Assistant messages will look like this:
    echo
    echo " ==> Hello from the lesson assistant <=="
    echo
    echo Type "go_away" to get rid of the assistant.
    echo
    echo " ==> Next command: $2 <=="
    tput sgr0
fi
