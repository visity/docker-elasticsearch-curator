#!/bin/bash

set -ex

# Add curator as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- curator "$@"
fi

## Find out who is the master
if [[ ${ELASTICSEARCH_MASTERS} ]]
then
  echo "Finding elasticsearch master from: $ELASTICSEARCH_MASTERS"
  for master in ${ELASTICSEARCH_MASTERS//,/ }
  do
    response=$(wget -qO- http://${master}:9200/_cat/master)
    if [ "$?" -eq 0 ]
    then
      ELASTICSEARCH_HOST=$(echo $response | awk '{printf $NF}')
      echo "Master found: $ELASTICSEARCH_HOST"
      break
    fi
  done
fi

# Step down via gosu  
if [ "$1" = 'curator' ]; then
	exec gosu curator bash -c "while true; do curator --host $ELASTICSEARCH_HOST --port $ELASTICSEARCH_PORT delete indices --older-than $OLDER_THAN_IN_DAYS --time-unit=days --timestring '%Y.%m.%d'; set -e; sleep $(( 60*60*INTERVAL_IN_HOURS )); set +e; done"
fi

# As argument is not related to curator,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
