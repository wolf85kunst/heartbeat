#!/bin/bash
# PARAMETRES
# ====================================================
date_format=`date +%H:%M-%d/%m/%Y` 
status_file='/root/heartbeat/heartbeat.status'
log_file='/root/heartbeat/heartbeat.log'
ip='192.168.1.101'
mail='hugo.gutekunst@gmail.com'
log_failed="[ $date_format ] FAILURE : The Raspberry Pi is dead."
log_recovery="[ $date_format ] RECOVERY : The Raspberry Pi is alive."
message_failed="La Raspberry Pi d'ip $ip est tombée !"
message_recovery="La Raspberry Pi d'ip $ip est ressuscitée !"
sujet_failed='RASPBERRY PI IS DEAD'
sujet_recovery='RASPBERRY PI IS UP'
# ===================================================

ping -c 1 -w 5 $ip >/dev/null 2>&1

if [ $? -ne 0 ]
then
	#echo 'marche pas'
	if [ "`cat $status_file`" == "ok" ]; then 
		echo $message_failed |mail -s "$sujet_failed" $mail 
		echo 'ko' >$status_file
		echo $log_failed >>$log_file
	fi
else
	#echo 'marche'
	if [ "`cat $status_file`" == "ko" ]; then 
		echo $message_recovery |mail -s "$sujet_recovery" $mail
		echo 'ok' >$status_file
		echo $log_recovery >>$log_file
	fi
fi

		





