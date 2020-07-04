FROM ruby:2.5.1-slim

RUN apt-get update && \
    apt-get install -y build-essential \
      libpq-dev \
      nodejs \
      libsqlite3-dev && \
    apt-get clean && \
    apt-get autoremove

ARG INSTALL_PATH=/app/

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock $INSTALL_PATH

RUN bundle install

ENTRYPOINT rails db:migrate && rails s
