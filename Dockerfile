FROM ruby:2.7.5
RUN apt-get update -qq && apt-get install -y nodejs
WORKDIR /chat-system
COPY . .
RUN bundle install

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
