FROM ruby:2.7.5
RUN apt-get update -qq && apt-get install -y nodejs cron
WORKDIR /chat-system
COPY . .
RUN bundle install
# Configure the main process to run when running the image
ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]