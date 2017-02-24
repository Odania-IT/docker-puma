#!/bin/bash
set -e
cd /srv/app

if [ ! -z "$PROCESS_TYPE" ] && [ $PROCESS_TYPE == 'background_worker' ]
then
	echo "Starting background worker"
	exec chpst -u app:app bundle exec sidekiq -e ${RAILS_ENV}
else
	echo "Starting puma web process"
	exec chpst -u app:app bundle exec puma -e ${RAILS_ENV} -p 3000 --threads 2:16
fi

