require 'sidekiq/api'

namespace :warmer do
  desc 'Start the recursive warm process, from entrypoint SITEMAP env variable'
  task start: :environment do
    # delete all old jobs scheduled, in favor to the new one
    Sidekiq::ScheduledSet.new.clear
    CacheWarmerJob.perform_later(ENV['SITEMAP'], true)
  end
end
