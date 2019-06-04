#!/bin/bash 
#Ps: this is recovery scirpt for gitlab.
if [ `/usr/bin/gitlab-ctl status | awk -F: '{print $1}' | head -n 1` == "down" ];then 
	/usr/bin/gitlab-ctl start 
else 
	echo "This is the current service state"
	echo "`/usr/bin/gitlab-ctl status`"
fi


