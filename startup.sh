#!/bin/bash
set -e
cd /srv/app

if [ ! -z "$PROCESS_TYPE" ] && [ $PROCESS_TYPE == 'background_worker' ]
then
	echo "Starting background worker"
	exec bundle exec sidekiq -e ${RAILS_ENV}
elif [ ! -z "$PROCESS_TYPE" ] && [ $PROCESS_TYPE == 'nginx' ]
then
	echo "Starting nginx asset serving"
	exec nginx -g "daemon off;"
else
	echo "Starting puma web process"
	exec bundle exec puma -e ${RAILS_ENV} -p 80 --threads 2:16
fi
