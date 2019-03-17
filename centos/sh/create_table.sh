#! /bin/sh

###
# create table
#
# with postgresql 8.4
#
# 2014 / 06 / 25
# written by choi, young-jo
#
# version: 1.2
###

###
# 테이블을 월간, 일간 단위로 파티셔닝 해준다.
# 큰 테이블의 속도 문제와 소프트 클러스터링 기능때문에 필요한 선행 작업이다.
###

readonly BASE_PATH=$(dirname ${0})
readonly TEMP_LOG_FILE_NAME=".log_temp"
readonly TEMP_LOG_FILE="${BASE_PATH}/${TEMP_LOG_FILE_NAME}"

readonly CREATE_LOG_FILE="create_log.sh"

readonly DBNAME="adcms"
readonly USERNAME="adcsmartdba"

export PGPASSFILE=/opt/adcsmart/scripts/cluster/.pgpass

function usage() {
    echo "Create Table"
    echo
    echo "Usage: ${0} ParentTableName TableNamespace YYYYMMDD"
}

function create_log() {
    sh "${BASE_PATH}/${CREATE_LOG_FILE}" >/dev/null 2>&1
}

function create_table() {
    local parent_table="${1}"
    local table_namespace="${2}"
    local table_name="${3}"
    local constraints_from_date="${4}"
    local constraints_to_date="${5}"

    echo "Create \"${table_name}\" Table" > "${TEMP_LOG_FILE}" 2>&1 

    local query_cmd="                                                   \
    BEGIN;                                                              \
    CREATE TABLE ${table_name}                                          \
    (                                                                   \
        CHECK(OCCUR_TIME >= '${constraints_from_date}'::timestamptz AND \
            OCCUR_TIME < '${constraints_to_date}'::timestamptz)         \
    ) INHERITS (${parent_table})                                        \
    TABLESPACE ${table_namespace};                                      \
    COMMIT;                                                             \
    "

    psql -d "${DBNAME}" -U "${USERNAME}" -c "${query_cmd}" >> "${TEMP_LOG_FILE}" 2>&1 

    create_log

    return 0
}

function create_table_and_rule() {
    local parent_table="${1}"
    local table_namespace="${2}"
    local table_name="${3}"
    local constraints_from_date="${4}"
    local constraints_to_date="${5}"

    echo "Create \"${table_name}\" Table And \"insert_${table_name}\" Rule" > "${TEMP_LOG_FILE}" 2>&1 

    local query_cmd="                                                   \
    BEGIN;                                                              \
    CREATE TABLE ${table_name}                                          \
    (                                                                   \
        CHECK(OCCUR_TIME >= '${constraints_from_date}'::timestamptz AND \
            OCCUR_TIME < '${constraints_to_date}'::timestamptz)         \
    ) INHERITS (${parent_table})                                        \
    TABLESPACE ${table_namespace};                                      \
                                                                        \
    CREATE RULE INSERT_${table_name}                                    \
    AS ON INSERT TO ${parent_table}                                     \
    WHERE (OCCUR_TIME >= '${constraints_from_date}'::timestamptz AND    \
            OCCUR_TIME < '${constraints_to_date}'::timestamptz)         \
    DO INSTEAD                                                          \
    INSERT INTO ${table_name} VALUES(NEW.*);                            \
    COMMIT;                                                             \
    "

    psql -d "${DBNAME}" -U "${USERNAME}" -c "${query_cmd}" >> "${TEMP_LOG_FILE}" 2>&1 

    create_log

    return 0
}

function main() {
    if [ ! $# -eq '3' ]; then
        usage
        exit 1
    fi

    local parent_table="${1}"
    local table_namespace="${2}"
    local date="${3}"
    local month_date="${date:0:6}01"

    # Create This Month Table 
    local this_month=`date +%Y%m -d "${month_date} + 0 month"`
    local table_name="${parent_table}_${this_month}"
    local constraints_from_date=`date +%Y-%m-01 -d "${month_date} + 0 month"`
    local constraints_to_date=`date +%Y-%m-01 -d "${month_date} + 1 month"`

    #echo "create this month table..."
    create_table "${parent_table}" "${table_namespace}" "${table_name}" "${constraints_from_date}" "${constraints_to_date}"


    # Create Next Month Table 
    local next_month=`date +%Y%m -d "${month_date} + 1 month"`
    table_name="${parent_table}_${next_month}"
    constraints_from_date=`date +%Y-%m-01 -d "${month_date} + 1 month"`
    constraints_to_date=`date +%Y-%m-01 -d "${month_date} + 2 month"`

    create_table "${parent_table}" "${table_namespace}" "${table_name}" "${constraints_from_date}" "${constraints_to_date}"


    # Create Today Table
    local today=`date +%Y%m%d -d "${date} + 0 day"`
    table_name="${parent_table}_${today}"
    constraints_from_date=`date +%Y-%m-%d -d "${date} + 0 day"`
    constraints_to_date=`date +%Y-%m-%d -d "${date} + 1 day"`

    create_table_and_rule "${parent_table}" "${table_namespace}" "${table_name}" "${constraints_from_date}" "${constraints_to_date}"


    # Create Nextday Table
    local nextday=`date +%Y%m%d -d "${date} + 1 day"`
    table_name="${parent_table}_${nextday}"
    constraints_from_date=`date +%Y-%m-%d -d "${date} + 1 day"`
    constraints_to_date=`date +%Y-%m-%d -d "${date} + 2 day"`

    create_table_and_rule "${parent_table}" "${table_namespace}" "${table_name}" "${constraints_from_date}" "${constraints_to_date}"

    exit 0
}

main "${@}"