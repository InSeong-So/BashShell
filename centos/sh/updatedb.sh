#!/bin/bash -l

LANG_OPT=$1

if [ "$LANG_OPT" = "" ]; then
    echo ""
    echo "*******************************************************"
    echo "ERROR: Oops, Invalid option"
    echo ""
    echo "Usage: updatedb.sh [OPTION]"
    echo "       OPTION : ko_kr ----- for korean"
    echo "       OPTION : en_US ----- for english"
    echo "*******************************************************"
    exit 0
fi

FILENAME="update_ko_kr.sql"

case "${LANG_OPT}" in
    "ko_kr" )
     	FILENAME="update_ko_kr.sql"
        ;;
    "en_us" )
     	FILENAME="update_en_us.sql"
        ;;
   *)
    echo ""
    echo "*******************************************************"
    echo "ERROR: Oops, Invalid option"
    echo ""
    echo "Usage: updatedb.sh [OPTION]"
    echo "       OPTION : ko_kr ----- for korean"
    echo "       OPTION : en_us ----- for english"
    echo "*******************************************************"
    exit 0
        ;;
esac
	    
if [ "$LANG_OPT" = "" ]; then
    echo ""
    echo "*******************************************************"
    echo "ERROR: Oops, Invalid option"
    echo ""
    echo "Usage: updatedb.sh [OPTION]"
    echo "       OPTION : ko_kr ----- for korean"
    echo "       OPTION : en_US ----- for english"
    echo "*******************************************************"
    exit 0
fi

# mount 여부 확인.
CHECKMNT=`mount|grep /mnt`
if [ ! "" = "$CHECKMNT" ]; then
    echo ""
    echo "*******************************************************"
    echo "ERROR: Oops, Already mount /mnt."
    echo "ERROR: Please check your system environment !!!!"
    echo ""
    echo "And then, execute following command:"
    echo "shell> umount /mnt"
    echo "*******************************************************"
    exit 0
fi

# device 확인.
CHECKMNT=`fdisk -l | grep /dev/sda2`
if [ "" = "$CHECKMNT" ]; then
    echo ""
    echo "*******************************************************"
    echo "ERROR: Oops, Invalid device."
    echo "*******************************************************"
    exit 0
fi

# db initializing
mount -t ext4 /dev/sda2 /mnt
FULLPATHNAME="/mnt/system/"$FILENAME
if [ -f $FULLPATHNAME ]; then
	psql -q -d adcms -U adcsmartdba -f $FULLPATHNAME
fi 

umount /mnt
