#!/bin/bash

sudo /scripts/lesson2_init.sh &>/dev/null

/scripts/welcome.sh "Lesson 2: Working With MBR" "lsblk" 2>/dev/null

cmd_list=cmd_list_2_1
source /scripts/assistant_commands.sh
