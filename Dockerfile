FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y \
    nodejs postgresql-client yarn build-essential sphinxsearch \ 
    && rm -rf /var/lib/apt/lists/*

ENV APP_HOME /SalesStore
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0"]
