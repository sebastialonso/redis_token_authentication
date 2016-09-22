FROM ruby:2.3.1
WORKDIR /app/
COPY ./Gemfile /app/
COPY ./Gemfile /app/
RUN BUNDLE_GEMFILE=/app/Gemfile bundle install
