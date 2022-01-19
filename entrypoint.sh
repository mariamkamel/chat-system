#!/bin/sh

bundle exec whenever --update-crontab && cron

exec "$@"