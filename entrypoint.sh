#!/bin/sh

rails db:migrate
bundle exec whenever --update-crontab && cron

exec "$@"