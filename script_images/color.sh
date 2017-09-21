#!/bin/bash

BLUE='\e[38;5;110m'
YELLOW='\e[38;5;136m'
GRAY='\033[1;30m'
COLOR=$YELLOW
CMDCOLOR='\e[38;5;243m'
NOCOLOR='\033[0m'

colorecho ()
{
    echo -e ${COLOR}${1}${NOCOLOR}
}

cmdecho ()
{
    echo -e "${COLOR} ==> Next command: ${CMDCOLOR}${1}${COLOR} <==${NOCOLOR}"
}

if [ -z "$(tail -n 1 ~/.bashrc | grep PS1)" ]; then
    echo "PS1='${debian_chroot:+($debian_chroot)}\[\e[38;5;28m\]\u@\h\[\033[00m\]:\[\e[38;5;61m\]\w\[\033[00m\]\$ '" >> ~/.bashrc
fi
