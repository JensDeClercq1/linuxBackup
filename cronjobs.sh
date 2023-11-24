#!/bin/bash
(crontab -l; echo "* * * * * /home/jensd/workflow.sh") | sort -u | crontab -

sleep 61m

crontab -r