#!/bin/bash

# Linux Chkconfig Conf.
# chkconfig: 2345 20 80
# description: Description comes here....


# Environment variable setting

#
# Source function library.
#
if [ -f /etc/rc.d/init.d/functions ]; then
    . /etc/rc.d/init.d/functions
fi

# export LANG="en_US.UTF-8"

readonly PROC_NAME="sendsms"
CONFPATH="/opt/adcsmart/cfg/${PROC_NAME}.properties"
JARPATH="/opt/adcsmart/bin/"

readonly PID_PATH="/var/run/"
readonly JAR_FILE="${PROC_NAME}-3.1.7-REALEASE.jar"

start() {
    echo "Starting ${PROC_NAME}..."

    local PROC_PID=$(get_status)
    if [ -n "${PROC_PID}" ]; then
        echo "  - service has already been started."
        exit 0
    fi
    
    sleep 3

    # Start Daemon
    nohup /opt/java/bin/java -Xms64m -Xmx64m -Dfile.encoding="UTF-8" -jar "${JARPATH}${JAR_FILE}" --spring.config.location=file:"${CONFPATH}" > /dev/null 2>&1 &

    sleep 3

    local PROC_PID=$(get_status)

    if [ -n "${PROC_PID}" ]; then
        echo "  - started successfully, PID ${PROC_PID}"
        echo ${PROC_PID} > "${PID_PATH}${PROC_NAME}.pid"
    else
        echo "  - failed to start."
    fi
}

stop() {
    echo "Stopping ${PROC_NAME}..."

    local PROC_PID=$(get_status)

    if [ -n "${PROC_PID}" ]; then
        rm -f "${PID_PATH}${PROC_NAME}.pid"
        
        # Stop Daemon
        kill -9 ${PROC_PID}

        sleep 1

        local PROC_PID=$(get_status)

        if [ -n "${PROC_PID}" ]; then
            echo "  - failed to stop service. try again."
        else
            echo "  - service was successfully stopped."
        fi
    else
        echo "  - service is not running"
    fi
}

status() {
    local PROC_PID=$(get_status)
 
    if [ -n "${PROC_PID}" ]; then
        echo "${PROC_NAME} is running"
    else
        echo "${PROC_NAME} is stopped"
    fi
}

#############################################
# 검사 후 비정상 종료되어 있으면 재 시작함. 
# 비정상 종료 여부는 pid 파일을 이용함.
#############################################
checkstart() {
  local PROC_PID=$(get_status)
  if [ -z "${PROC_PID}" ]; then
    if [ ! -f "${PID_PATH}${PROC_NAME}.pid" ]; then
      ## 정상. process는 없고 pid 파일도 없는 경우. 의도적으로 정지시킨 경우임.
      exit 0
    else
      ## 비정상. process id는 없고 pid 파일은 있는 경우. 비정상 종료된 경우임.
      stop
      sleep 3
      start
    fi
  else 
    echo "${PROC_NAME} process is already running"
  fi
}

get_status() {
    ps uxww | grep ${JAR_FILE} | grep -v grep | awk '{print $2}'
}

get_process_count()
{
	# check the args
  if [ "$1" = "" ];
  then
  		return 1
  fi

	PROCESS_NUM=$(ps aux | grep -c $1)
	return $PROCESS_NUM
}

check_process()
{
  # check the args
  if [ "$1" = "" ];
  then
  		return 1
  fi

  get_process_count $1
  PCNT=$?
  if [ $PCNT -le 0 ]; then
   	# 오류 상황?. 한번더 시도한 후 시도한 값을 리턴한다.
    DATE2=`/bin/date`
		echo “[$DATE2]  failed to check process $1. process_count: $PCNT. try to check again.... ” >> /opt/adcsmart/logs/scripts.log
	 	sleep 1
	 	get_process_count $1
	 	RVAL=$?
 		DATE2=`/bin/date`
		echo “[$DATE2] process $1 check result: process_count: $RVAL ” >> /opt/adcsmart/logs/scripts.log
	 	return $RVAL
	elif [ $PCNT -eq 1 ]; then
	  # 프로세스가 없는 경우. 다시한번 검사한다.
 		DATE2=`/bin/date`
		echo “[$DATE2]  failed to check process $1. process_count: $PCNT. try to check again.... ” >> /opt/adcsmart/logs/scripts.log
	 	sleep 1
	 	get_process_count $1
	 	RVAL=$?
 		DATE2=`/bin/date`
		echo “[$DATE2] process $1 check result: process_count: $RVAL ” >> /opt/adcsmart/logs/scripts.log
	 	return $RVAL
	elif [ $PCNT -eq 2 ]; then
		# 하나의 프로세스만 떠 있는 경우. 정상인 경우임.
		return $PCNT
	elif [ $PCNT -ge 3 ]; then
		# 2개 이상의 프로세스만 떠 는 경우.
 		DATE2=`/bin/date`
		echo “[$DATE2] process $1 is invalid status. process_count: $PROCESS_NUM ” >> /opt/adcsmart/logs/scripts.log
		return $PCNT
	else
	  # 기타 상황. 오류 상황임.
 		DATE2=`/bin/date`
		echo “[$DATE2]  failed to check process $1. process_count: $PCNT. try to check again.... ” >> /opt/adcsmart/logs/scripts.log
	 	sleep 1
	 	get_process_count $1
	 	RVAL=$?
 		DATE2=`/bin/date`
		echo “[$DATE2] process $1 check result: process_count: $RVAL ” >> /opt/adcsmart/logs/scripts.log
	 	return $RVAL
	fi
}

checkDaemonAll()
{
	check_process $JAR_FILE
	APPCHK=$?
#	APPCHK=$(ps aux | grep -c $PRG_ADCMON)
	if [ $APPCHK -eq 1 ]; then
		start
		rval=$?
		if [ $rval -eq 1 ];then
			DATE2=`/bin/date`
			echo “[$DATE2] success to start the $PRG_ADCMON process” >> /opt/adcsmart/logs/scripts.log	
		else
			DATE2=`/bin/date`
			echo “[$DATE2] try to start the $PRG_ADCMON process, but the process is already running” >> /opt/adcsmart/logs/scripts.log	
		fi
	elif [ $APPCHK -ge 3 ]; then
		stop
		sleep 1
		start
		rval=$?
		if [ $rval -eq 1 ];then
			DATE2=`/bin/date`
			echo “[$DATE2] success to start the $PRG_ADCMON process” >> /opt/adcsmart/logs/scripts.log	
		else
			DATE2=`/bin/date`
			echo “[$DATE2] try to start the $PRG_ADCMON process, but the process is already running” >> /opt/adcsmart/logs/scripts.log	
		fi
	else
		DATE2=`/bin/date`
		echo “[$DATE2]  $PRG_ADCMON is running processes” >> /opt/adcsmart/logs/scripts.log
	fi
	
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        sleep 3
        start
        ;;
    checkstart)
        checkstart "${PROC_NAME}"
        ;;
    status)
        status "${PROC_NAME}"
        ;;
    *)
      checkDaemonAll
      exit 1;
esac

exit 0
