FROM ruby:2.5.1
MAINTAINER Xu Yunlong <yunlong@veer.tv>

RUN apt-get update
RUN apt-get install -y --no-install-recommends nodejs

# Install gems
ENV APP_HOME /opt/vcam/dogfood_producer/current
RUN mkdir -p ${APP_HOME}
WORKDIR ${APP_HOME}
COPY Gemfile* ${APP_HOME}/
RUN gem install bundler && bundle install --jobs 20 --retry 5 \
    && mkdir -p ${APP_HOME}/log \
    && mkdir -p ${APP_HOME}/tmp \
    && mkdir -p ${APP_HOME}/tmp/pids \
    && mkdir -p ${APP_HOME}/tmp/sockets

# Upload source
COPY . ${APP_HOME}
