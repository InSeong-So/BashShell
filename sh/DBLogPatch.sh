###############################################################################################
# DB 패치
###############################################################################################
patch_db() {
#  printf "Try to patch db ..........................................................\n"
  printf "Try to patch db .........................................................."
  local SQL_FILE=$1
  if [ -f "${SQL_FILE}" ]; then
    RET=$(psql -h localhost -d adcms -U adcsmartdba -f ${SQL_FILE} ||:)
    RET=$?
    setlog "dbpatch Update DB" $RET
  fi
  printf " [done]\n"
}