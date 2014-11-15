#!/usr/bin/env bash

HBASE_URL=http://apache.osuosl.org/hbase/stable/hbase-0.98.7-hadoop2-bin.tar.gz
HBASE_FILE_DESTINATION=/tmp/hbase-0.98.7-hadoop2-bin.tar.gz
HBASE_INSTALL=/opt/hbase
HBASE_DATA=/opt/hbase-data

set -x

if [ ! -e ${HBASE_FILE_DESTINATION} ]
then
    wget -O ${HBASE_FILE_DESTINATION} ${HBASE_URL}
else
    echo "${HBASE_FILE_DESTINATION} already exists"
fi

if [ ! -e ${HBASE_INSTALL} ]
then
    tar -C /opt -zxf ${HBASE_FILE_DESTINATION}
    mv /opt/hbase-* ${HBASE_INSTALL}
else
    echo "hbase previously extracted to ${HBASE_INSTALL}"
fi

if [ ! -e ${HBASE_DATA} ]
then
    mkdir -p ${HBASE_DATA}
else
    echo "hbase data directory previously created"
fi

grep opt ${HBASE_INSTALL}/conf/hbase-site.xml
if [ $? -eq 0 ]
then
    echo "hbase already configured"
else
    cp /tmp/hbase-site.xml ${HBASE_INSTALL}/conf/hbase-site.xml
fi
