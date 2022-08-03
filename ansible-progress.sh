#!/bin/bash

{
ANSIBLE_LOCALHOST_WARNING=false ansible-playbook playbook.yml -i inventory.ini > /tmp/ansible-progress.log &
PID=$!
LAST_PERCENT=0
while ps -p $PID &>/dev/null; do
    CURRENT_TASK_NUM=$(grep TASK /tmp/ansible-progress.log | tail -n 1 | sed -e "s/\**//g" | sed -e "s/^TASK //g" | awk '{print $1}' | cut -d "/" -f 1)
    TOTAL_TASK_NUM=$(grep TASK /tmp/ansible-progress.log | tail -n 1 | sed -e "s/\**//g" | sed -e "s/^TASK //g" | awk '{print $1}' | cut -d "/" -f 2)
    CURRENT_MESSAGE=$(grep TASK /tmp/ansible-progress.log | tail -n 1 | sed -e "s/\**//g" | sed -e "s/^TASK //g" | cut -d "[" -f 2 | sed -e "s/]//g")
    if [[ -n $CURRENT_TASK_NUM ]]; then
        CURRENT_PERCENT=$((($CURRENT_TASK_NUM * 100) / $TOTAL_TASK_NUM))
        if [ $CURRENT_PERCENT -gt 0 ] && [ $CURRENT_PERCENT -lt 101 ] && [ ! "$CURRENT_PERCENT" -eq "$LAST_PERCENT" ]; then
            echo -ne "XXX\n$CURRENT_PERCENT\n$CURRENT_MESSAGE\nXXX\n"
            LAST_PERCENT=$CURRENT_PERCENT
        fi
    fi
done
} | whiptail  --clear --gauge "Please wait.... " 6 60 0