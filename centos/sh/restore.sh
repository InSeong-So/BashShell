#!/bin/bash -l

DATA="$1"
TEMP=temp

if [ -z "$DATA" ];
then
	exit 1
fi

if [ ! -f "$DATA" ];
then
	exit
fi

rm -rf $TEMP; mkdir $TEMP
tar zxf $DATA -C $TEMP

echo ""
echo "`date` - restored tables" > restore.log

for FILE_NAME in `find $TEMP -type f | grep ".pg"`	#for each file(!directory) of which extension is "pg"
do
	TABLE_NAME=`basename $FILE_NAME | cut -d . -f 1` #remove extension part by cut with delimeter dot(.)

	#drop existing table
	/usr/bin/psql -U adcsmartdba -d adcms  -c "DROP TABLE $TABLE_NAME;"
	#restore table
	/usr/bin/pg_restore -U adcsmartdba -Fc -d adcms $FILE_NAME
	RET=$?

	#notify
	if [ $RET -eq 0 ]; then
		echo "RESTORE TABLE $TABLE_NAME - SUCCESS"
		echo "$TABLE_NAME,SUCCESS" >> restore.log
	else
		echo "RESTORE TABLE $TABLE_NAME - FAIL"
		echo "$TABLE_NAME,FAIL" >> restore.log
	fi
done

rm -rf $TEMP

exit 1
