set :environment, "development"
ENV.each { |k, v| env(k, v) }

set :output, "/cron.txt"
every 30.minute do
    rake 'jobs:update_counts'
end