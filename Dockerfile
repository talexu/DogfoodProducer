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

ENV SECRET_KEY_BASE d972af1231978d7b0c9e6ed2c0d06006367449a27d2a14b4c7e1874b81864fe0a47108045adb15e4044678131f705803cd7465f67e948f25d9b7b262ecdb9806
RUN RAILS_ENV=production bundle exec rake assets:precompile
