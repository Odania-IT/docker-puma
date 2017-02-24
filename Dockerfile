FROM odaniait/docker-base:alpine
MAINTAINER Mike Petersen <mike@odania-it.de>

# Prepare /srv directory
RUN mkdir -p /srv/app
RUN addgroup --gid 9999 app
RUN adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app
RUN usermod -L app
RUN mkdir -p /srv/.ssh
RUN chmod 700 /srv/.ssh
RUN chown app:app /srv/.ssh
RUN chown -R app:app /srv
ENV HOME /srv
WORKDIR /srv/app

# Add startup script
RUN mkdir -p /etc/my_init.d
COPY select_type.sh /etc/my_init.d/01-select_type.sh

# Add puma service
RUN mkdir -p /etc/service/puma
COPY runit/runit_puma.sh /etc/service/puma/run
RUN touch /etc/service/puma/down

# Add sidekiq service
RUN mkdir -p /etc/service/sidekiq
COPY runit/runit_sidekiq.sh /etc/service/sidekiq/run
RUN touch /etc/service/sidekiq/down
