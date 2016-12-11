#!/usr/bin/env bash
cd /srv/app

echo "Starting puma"
exec chpst -u app:app bundle exec puma -e ${RAILS_ENV} -p 3000 --threads 2:16

