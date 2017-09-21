#!/bin/bash

YELLOW='\033[1;33m'
COLOR=$YELLOW
NOCOLOR='\033[0m'

colorecho ()
{
    echo -e ${COLOR}${1}${NOCOLOR}
}
