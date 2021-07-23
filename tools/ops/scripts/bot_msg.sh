#!/bin/bash

SLACK_TOKEN="REPLACEME"

Running_VMs=$(/root/tools/list |awk '{print $1,$3,$4}' |grep running |grep -v "gw1" |awk '{print $1}' |tr '\n' 'X' |sed 's/X/\\n/g')
Running_VMs_Count=$(cat /tmp/vms_running.txt |wc -l)

msg="
There are currently "$Running_VMs_Count" VMs (excluding cgw) running on Cloud RSCFD :awooga:\n
Please check following nodes are expected to be running:\n
"$Running_VMs"
"

cat <<EOF | curl --data @- -X POST -H "Authorization: Bearer $SLACK_TOKEN" -H 'Content-Type: application/json' https://slack.com/api/chat.postMessage
	{
  		"text": "$msg",
  		"channel": "clustername",
  		"as_user": true
	}
EOF


