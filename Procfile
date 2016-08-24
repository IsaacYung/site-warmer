worker: bundle exec rake warmer:start; bundle exec sidekiq -C ./config/sidekiq.yml
redirect_queue: bundle exec sidekiq -C ./config/sidekiq-redirects.yml
bot: bundle exec rake bot:wake_up
