#!/bin/bash 

export program_path="$1"
export archive_path="$2"
export source_path="$3"
export date="$4"
export ACTION="$5" 
echo ${ACTION}

export start_file="/usr/bin/supervisorctl" 
export source_backup="/data/src/lotterybackup"
export program_backup="/opt/lotteryTicket/backup"

[ ! $1 ] && exit
[ ! $2 ] && exit 
[ ! $3 ] && exit 
[ ! $4 ] && exit 
[ ! $5 ] && exit 
#program_path='/opt/lotteryTicket'
#
#archive_path="/usr/local/jenkins_data/workspace/test17_lottery-Ticket_172.16.10.96"
#
#source_path="/data/src/lotteryTicket"
#
#date=`date +%F-%H-%M`

#now funcation
source_backup () {
	[ -d ${source_backup} ] || mkdir ${source_backup}
	[ -d ${program_backup} ] || mkdir ${program_backup}
	tar cf lotteryTicket-${date}.tar.gz ${source_path}/  
	mv lotteryTicket-${date}.tar.gz ${source_backup} && cd ${source_backup} && rm -f `ls -t ${source_backup:=UNSET} | tail -n +3`
	cp -f ${source_path}/lotteryTicket ${program_path}/
	cp -f ${program_path}/lotteryTicket ${program_backup}/lotteryTicket-${date} && cd ${program_backup} && rm -f `ls -t ${program_backup:=UNSET} | tail -n +3`  
	cd ${program_path} && ${start_file} restart lotteryTicket	
	
}


#backup funcation
backup_funcation () {
	cd ${program_path} && rm -f ${program_path}/lotteryTicket
	ln -s ${program_backup}/`ls -t ${program_backup}/ | head -n +1` ${program_path}/lotteryTicket
	cd ${program_path} && ${start_file} restart lotteryTicket	
}

case $ACTION  in 
	now)
		source_backup 
	;;	
	backup)
		backup_funcation
	;;
esac
