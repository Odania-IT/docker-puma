FROM odaniait/docker-base:ubuntu
MAINTAINER Mike Petersen <mike@odania-it.de>

# Prepare nginx
RUN apt-get update && apt-get install -y nginx && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN sed -i -e 's#access_log /var/log/nginx/access.log;#access_log /dev/stdout;#' /etc/nginx/nginx.conf
RUN sed -i -e 's#error_log /var/log/nginx/error.log;#error_log /dev/stderr;#' /etc/nginx/nginx.conf
RUN sed -i -e 's/# server_names_hash_bucket_size 64;/server_names_hash_bucket_size 64;/' /etc/nginx/nginx.conf

# Prepare /srv directory
RUN mkdir -p /srv/app
RUN addgroup --gid 9999 app
RUN adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app
RUN usermod -L app
RUN mkdir -p /srv/.ssh
RUN chmod 700 /srv/.ssh
RUN chown app:app /srv/.ssh
RUN chown -R app:app /srv
RUN chown -R app:app /var/lib/nginx/
ENV HOME /srv
WORKDIR /srv/app

# Add startup script
COPY startup.sh /startup.sh
COPY default.conf /etc/nginx/sites-enabled/default
RUN chown -R app:app /startup.sh

CMD '/startup.sh'
EXPOSE 80
USER app
