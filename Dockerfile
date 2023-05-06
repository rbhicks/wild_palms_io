FROM elixir:latest

RUN apt-get update && apt-get install --yes postgresql-client

ENV APP_HOME /wild_palms_io
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN mix local.hex --force  && mix archive.install --force hex phx_new 1.7.2  && apt-get update  && apt-get install -y apt-utils  && apt-get install -y build-essential  && apt-get install -y inotify-tools
