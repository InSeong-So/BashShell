#! /bin/sh

# 이 스크립트를 실행할 때,
# 옵션 없음: 작업 중간에 sleep 함
# -n 옵션: 작업 중간에 sleep 안함

readonly BASE_PATH=$(dirname ${0})
readonly FILE_NAME="table_management.sh"
readonly FILE_PATH="${BASE_PATH}/${FILE_NAME}"

chmod 0600 /opt/adcsmart/scripts/cluster/.pgpass
export PGPASSFILE=/opt/adcsmart/scripts/cluster/.pgpass

function main() {
    # 같은 테이블에 대해서 작업을 하는 경우, 뒤의 작업은 소프트 클러스터링 기능을 활용할 수 없다.
    # 하나의 테이블에하는 한 번의 소프트 클러스터링만 한다.
    # 즉, 같은 테이블 일 경우에는 먼저 나온 작업의 인덱스를 참고하여 소프트 클러스터링을 한다.

    printf "Try to Create Log Table ................................................."

    local sleep_flag="${1:--s}"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_ADC_FAULT             "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_ADC_FAULT             "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [1/33]\n"
    printf "Try to Create Log Table ................................................."

    sh "${FILE_PATH}" "${sleep_flag}" LOG_ADC_PERF_STATS        "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_ADC_PERF_STATS        "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [2/33]\n"
    printf "Try to Create Log Table ................................................."

    sh "${FILE_PATH}" "${sleep_flag}" LOG_ADC_PERFORMANCE       "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_ADC_PERFORMANCE       "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [3/33]\n"
    printf "Try to Create Log Table ................................................."

    sh "${FILE_PATH}" "${sleep_flag}" LOG_ADC_SYSLOG            "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_ADC_SYSLOG            "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [4/33]\n"
    printf "Try to Create Log Table ................................................."

    sh "${FILE_PATH}" "${sleep_flag}" LOG_FAN_STATUS            "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_FAN_STATUS            "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [5/33]\n"
    printf "Try to Create Log Table ................................................."

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_BPS_IN           "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_BPS_IN           "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [6/33]\n"
    printf "Try to Create Log Table ................................................."

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_BPS_OUT          "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_BPS_OUT          "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [7/33]\n"
    printf "Try to Create Log Table ................................................."

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_BYTE_IN          "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_BYTE_IN          "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [8/33]\n"
    printf "Try to Create Log Table ................................................."

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_BYTE_OUT         "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_BYTE_OUT         "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [9/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_CONNECTOR_TYPE   "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_CONNECTOR_TYPE   "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [10/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_DPS_IN           "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_DPS_IN           "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [11/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_DPS_OUT          "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_DPS_OUT          "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [12/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_EPS_IN           "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_EPS_IN           "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [13/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_EPS_OUT          "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_EPS_OUT          "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [14/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_MODE             "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_MODE             "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [15/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_PKT_DROP         "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_PKT_DROP         "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [16/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_PKT_ERR          "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_PKT_ERR          "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [17/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_PKT_IN           "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_PKT_IN           "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [18/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_PKT_OUT          "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_PKT_OUT          "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [19/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_PPS_IN           "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_PPS_IN           "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [20/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_PPS_OUT          "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_PPS_OUT          "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [21/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_STATUS           "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_STATUS           "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [22/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_UPTIME_STATUS    "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_LINK_UPTIME_STATUS    "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [23/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_POOLGROUP_PERF_STATS  "(GROUP_INDEX, OCCUR_TIME)" group_index_occur_time  ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_POOLGROUP_PERF_STATS  "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time  ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_POOLGROUP_PERF_STATS  "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_POOLGROUP_PERF_STATS  "(GROUP_INDEX)"             group_index             ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [24/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_POWERSUPPLY_STATUS    "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_POWERSUPPLY_STATUS    "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [25/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_REAL_PERF_STATS       "(REAL_INDEX, OCCUR_TIME)"  real_index_occur_time   ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_REAL_PERF_STATS       "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time   ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_REAL_PERF_STATS       "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_REAL_PERF_STATS       "(REAL_INDEX)"              real_index              ADCSMART_LOGS   ADCSMART_INDEXES 

    printf " [26/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_RESC_CPUMEM           "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_RESC_CPUMEM           "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [27/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_RESC_HDD              "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_RESC_HDD              "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [28/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_GROUP_PERF_STATS  "(OBJ_INDEX, OCCUR_TIME)"   obj_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_GROUP_PERF_STATS  "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_GROUP_PERF_STATS  "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_GROUP_PERF_STATS  "(OBJ_INDEX)"               obj_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [29/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_MEMBER_PERF_STATS "(OBJ_INDEX, OCCUR_TIME)"   obj_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_MEMBER_PERF_STATS "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_MEMBER_PERF_STATS "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_MEMBER_PERF_STATS "(OBJ_INDEX)"               obj_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [30/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_PERF_RESP_TIME    "(OBJ_INDEX, OCCUR_TIME)"   obj_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_PERF_RESP_TIME    "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_PERF_RESP_TIME    "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_PERF_RESP_TIME    "(OBJ_INDEX)"               obj_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [31/33]\n"
    printf "Try to Create Log Table ................................................"

    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_PERF_STATS        "(OBJ_INDEX, OCCUR_TIME)"   obj_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_PERF_STATS        "(ADC_INDEX, OCCUR_TIME)"   adc_index_occur_time    ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_PERF_STATS        "(ADC_INDEX)"               adc_index               ADCSMART_LOGS   ADCSMART_INDEXES
    sh "${FILE_PATH}" "${sleep_flag}" LOG_SVC_PERF_STATS        "(OBJ_INDEX)"               obj_index               ADCSMART_LOGS   ADCSMART_INDEXES

    printf " [32/33]\n"
    printf "Try to Create Log Table ................................................"

    ## 163 장비, 수원 장비
    sh "${FILE_PATH}" "${sleep_flag}" LOG_SYSTEM_RESOURCES      "(OCCUR_TIME)"              occur_time              ADCSMART_LOGS   ADCSMART_INDEXES 

    printf " [33/33]\n"
}
printf "\n"
printf "\n"
printf "\n[.............................. CREATE LOG TABLE ..............................]"
printf "\n================================================================================"
printf "\n"
printf "\n"
main "${@}"
printf "\n"
printf "\n================================================================================"
printf "\n[................................. FINISHED ...................................]\n"