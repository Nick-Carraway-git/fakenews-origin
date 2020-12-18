FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim

RUN mkdir /fakenews
WORKDIR /fakenews

ADD ./Gemfile /fakenews/Gemfile
ADD ./Gemfile.lock /fakenews/Gemfile.lock

RUN bundle install
ADD . /fakenews
