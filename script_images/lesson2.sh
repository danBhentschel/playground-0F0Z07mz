#!/bin/bash

sudo /scripts/init_pool.sh &>/dev/null

/scripts/welcome.sh "Lesson 2: Working With Loop Devices" "lsblk -f" 2>/dev/null

cmd_list=cmd_list_2_1
source /scripts/assistant_commands.sh
