# docker-puma

Provide a docker container for running a puma app or sidekiq.

You can control if puma or sidekiq is started with the environment variable PROCESS_TYPE

It will start puma if it is not set to 'background_worker'
