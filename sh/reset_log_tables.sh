#!/bin/bash
#set -x
#Variable Defined
filePath="/root/reset_log_tables/"

# Arrays Defined : SQL FILE 
sqlList=(`ls -l $filePath | awk '{print $9}' | sort`)
sqlNameList=("ADC STATUS HISTORY" "SLB CONFIG HISTORY" "ALERT MESSAGE DISABLED HISTORY" "FAN STATUS HISTORY" "FAULT CHECKING HISTORY" "LINK INFORMATION HISTORY" "PACKET COLLECT HISTORY" "GROUP STATUS HISTORY" "POWER SUPPLY STATUS HISTORY" "PROFILE CONFIG HISTORY" "REAL STATUS HISTORY" "REPORT HISTORY" "CPU/MEMORY/CONN/HDD/TEMP.. DATA HISTORY" "RESPONSE HISTORY" "RESPONSE DETAILS HISTORY" "SERVICE STATUS HISTORY" "SYSTEM STATUS HISTORY")
## sqlFileNameList=("log_adc.sql" "log_config.sql" "log_disable.sql" "log_fan.sql" "log_fault.sql" "log_link.sql" "log_pkt.sql" "log_poolgroup.sql" "log_powersupply.sql" "log_profile.sql" "log_real.sql" "log_report.sql" "log_resc.sql" "log_resp.sql" "log_summary.sql" "log_svc.sql")

# Method Defined : SQL EXCUTE
reset_log_table() {
  if (( ${#sqlList[@]} )) ; then
    for index in ${!sqlList[*]} ; do
      if [ $index -eq 17 ] ; then
        break
      fi
      printf "\n\nRESET : %s..................................................................\n\n" "${sqlNameList[$index]}"
      RET=$(psql -h localhost -d adcms -U adcsmartdba -f ${sqlList[$index]} ||:) > /dev/null 2>&1
      echo ""
      echo ".................................................................................................. [done]"
      echo ""
    done
    echo ""
    echo "============================================= Table Create? ============================================="
    echo "                                           [ Y / N (y or n) ]                                            "
    read b_input
    if [ $b_input = "y" -o $b_input = "Y" ] ; then
      /opt/adcsmart/scripts/cluster/run_management.sh
    elif [ $b_input = "n" -o $b_input = "N" ] ; then
      echo " [ LOG CREATE EXIT ] "
    else
      echo " [ UNSUPPORTED FORMAT ] "
    fi
  else
    echo ""
    printf "\n [ %slog_*.sql FILES NOT EXIST ] \n" "$filePath"
    echo ""
  fi
}

##################
### StartPoint ###
##################

# Authentication
chmod 600 ~/.pgpass

# Choose List
echo "CHOOSE YOUR WORK"
echo "1. LOG RESET"
echo "2. EXIT"
read a_input > /dev/null 2>&1

# Working
if [ $a_input -eq 1 ] ; then
  reset_log_table
  chmod 644 /root/.pgpass
else
  echo ""
  echo " [ EXIT ] "
  echo ""
fi