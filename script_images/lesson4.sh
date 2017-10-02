#!/bin/bash

sudo /scripts/init_pool.sh &>/dev/null

/scripts/welcome.sh "Lesson 4: GPT Partitions" "truncate -s 3T /pool/disk1" 2>/dev/null

cmd_list=cmd_list_4_1
source /scripts/assistant_commands.sh
