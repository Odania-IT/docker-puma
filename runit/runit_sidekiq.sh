#!/usr/bin/env bash
cd /srv/app

echo "Starting sidekiq"
exec chpst -u app:app bundle exec sidekiq -e ${RAILS_ENV}

