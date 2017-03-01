FROM odaniait/docker-base:ubuntu
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
COPY startup.sh /startup.sh
COPY default.conf /etc/nginx/sites-enabled/default
RUN chown -R app:app /startup.sh

CMD '/startup.sh'
EXPOSE 3000
USER app
