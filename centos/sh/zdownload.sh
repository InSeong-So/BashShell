#!/bin/bash -l

WORKDIR="/var/tmp"

if [ ! -d ${WORKDIR} ] ; then
	mkdir -p ${WORKDIR}
fi

FILENAME=$1

if [ "$FILENAME" = "" ]; 
then
	exit 0
fi

pushd . > /dev/null 2>&1

cd $WORKDIR

/usr/bin/lrz -y -v -q -f $FILENAME

popd > /dev/null 2>&1

