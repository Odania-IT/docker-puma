#!/bin/bash
set -e
cd /srv/app

if [ ! -z "$PROCESS_TYPE" ] && [ $PROCESS_TYPE == 'background_worker' ]
then
	echo "Starting background worker sidekiq"
	exec bundle exec sidekiq -e ${RAILS_ENV}
elif [ ! -z "$PROCESS_TYPE" ] && [ $PROCESS_TYPE == 'nginx' ]
then
	echo "Starting nginx asset serving"
	exec nginx -g "daemon off;"
elif [ ! -z "$PROCESS_TYPE" ] && [ $PROCESS_TYPE == 'resque' ]
then
	echo "Starting background worker resque"
	exec QUEUE=* COUNT=2 bundle exec rake resque:workers
elif [ ! -z "$PROCESS_TYPE" ] && [ $PROCESS_TYPE == 'resque_scheduler' ]
then
	echo "Starting resque_scheduler"
	exec bundle exec rake resque:scheduler
else
	echo "Starting puma web process"
	exec bundle exec puma -e ${RAILS_ENV} -p 3000 --threads 2:16
fi
