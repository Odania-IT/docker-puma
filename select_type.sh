#!/bin/bash
set -e

if [ ! -z "$PROCESS_TYPE" ] && [ $PROCESS_TYPE == 'background_worker' ]
then
	echo "Starting background worker"
	rm -f /etc/service/sidekiq/down
else
	echo "Starting puma web process"
	rm -f /etc/service/puma/down
fi

