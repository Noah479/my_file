#!/bin/bash 
#this is a system infomation script.
#histroy 2019-4-11
CPUDoage=`expr 100 - $(mpstat | tail -1 | awk '{print $12}' | awk -F. '{print $1}')`
Usedmemory=`free -m | egrep "Mem" | awk '{print $3}'`
Totalmemory=`free -m | egrep "Mem" | awk '{print $2}'`
onlymemory=`expr $Usedmemory \* 100 / $Totalmemory`

diskused=`df -h | egrep "/$" | awk '{print $5}' | awk '{print $1}'`
diskused2=`df -h | egrep "/$" | awk '{print $5}' | awk '{print $1}' | awk -F% '{print $1}'`
onlydiskused=`df -h | egrep "/$" | awk '{print $5}'`

echo -e "\033[36m+++++++++++++++++++++++++++++++++ \033[0m" 
echo "This is CPU Dosage info." 
echo ""
echo "Your CPU already used $CPUDoage %"

echo -e "\033[36m+++++++++++++++++++++++++++++++++ \033[0m" 
echo "This is memory info."
echo ""
echo "Your Memory used $onlymemory %"

echo -e "\033[36m+++++++++++++++++++++++++++++++++ \033[0m" 
echo "This is disk info."
echo ""
echo "Your disk used $diskused "
echo ""

if [ $diskused2 -gt 10 ]
then
    echo -e "\033[31mWarning : Your Disk soon full.\033[0m"
	mail -s "disk"  127.0.0.1 < /tmp/disk.txt
elif [ $onlymemory -gt 90 ]
then
    echo -e "\033[31mWarning : Your Memory soon full.\033[0m"
	mail -s "memory"  127.0.0.1 < /tmp/memory.txt
elif [ $CPUDoage -gt 90 ]
then
    echo -e "\033[31mWarning : Your CPU soon full.\033[0m"
	mail -s "cpu"  127.0.0.1 < /tmp/cpu.txt
fi


