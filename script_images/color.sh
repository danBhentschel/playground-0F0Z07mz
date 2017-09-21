#!/bin/bash

YELLOW='\033[1;33m'
DKYELLOW='\033[0;33m'
GRAY='\033[0;37m'
COLOR=$YELLOW
CMDCOLOR=$DKYELLOW
NOCOLOR='\033[0m'

colorecho ()
{
    echo -e ${COLOR}${1}${NOCOLOR}
}

cmdecho ()
{
    echo -e "${COLOR} ==> Next command: ${CMDCOLOR}${1}${COLOR} <==${NOCOLOR}"
}
