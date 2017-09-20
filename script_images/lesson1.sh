#!/bin/bash

/scripts/welcome.sh "Lesson 1: Discovering Partitions" "lsblk" 2>/dev/null

sudo /scripts/lesson1_init.sh

cmd_list=cmd_list_1_1
source /scripts/assistant_commands.sh
