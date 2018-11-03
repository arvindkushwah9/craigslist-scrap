# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
1. cd craigslist-scrap
2. bundle install
3. rake db:setup
4. rails s
5. Run Sidekiq for background process

## To start Redis

sudo service redis-server restart

##clear rediscache
redis-cli flushall

## To Start Sidekiq in production env
bundle exec sidekiq -d -L sidekiq.log -q mailer,5 -q default -e production
