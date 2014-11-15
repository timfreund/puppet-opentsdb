#!/usr/bin/env bash

OTSDB_URL=https://github.com/OpenTSDB/opentsdb/releases/download/v2.0.1/opentsdb-2.0.1_all.deb
OTSDB_FILE_DESTINATION=/tmp/opentsdb-2.0.1_all.deb

if [ ! -e ${OTSDB_FILE_DESTINATION} ]
then
    wget -O ${OTSDB_FILE_DESTINATION} ${OTSDB_URL}
else
    echo "${OTSDB_FILE_DESTINATION} already exists"
fi

dpkg -i ${OTSDB_FILE_DESTINATION}
