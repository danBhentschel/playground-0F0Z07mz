#!/bin/bash

sudo /scripts/lesson1_init.sh &>/dev/null

/scripts/welcome.sh "Lesson 1: Discovering Partitions" "lsblk" 2>/dev/null

cmd_list=cmd_list_1_1
source /scripts/assistant_commands.sh
