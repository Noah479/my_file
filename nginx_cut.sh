#!/bin/bash
s_log=/usr/local/nginx/logs/access.log
d_log=/usr/local/nginx/logs/access`date +%Y%m%d`.log
mv $s_log $d_log
kill -USR1 `cat /usr/local/nginx/logs/nginx.pid`

