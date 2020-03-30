FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn build-essential

ENV APP_HOME /SalesStore
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
