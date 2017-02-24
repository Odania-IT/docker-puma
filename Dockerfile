FROM odaniait/docker-base:alpine
MAINTAINER Mike Petersen <mike@odania-it.de>

# Prepare /srv directory
RUN mkdir -p /srv/app
RUN addgroup -g 9999 app
RUN adduser -u 9999 -G app -D -g "Application" app
RUN mkdir -p /srv/.ssh
RUN chmod 700 /srv/.ssh
RUN chown app:app /srv/.ssh
RUN chown -R app:app /srv
ENV HOME /srv
WORKDIR /srv/app

# Add startup script
COPY startup.sh /startup.sh

CMD ['/startup.sh']
EXPOSE 3000
USER app
