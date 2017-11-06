#!/bin/bash

sudo /scripts/init_pool.sh &>/dev/null

/scripts/welcome.sh "Lesson 5: GPT Partitions with gdisk" "truncate -s 3T /pool/disk1" 2>/dev/null

cmd_list=cmd_list_5_1
source /scripts/assistant_commands.sh
