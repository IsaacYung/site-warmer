class CacheWarmerJob < ActiveJob::Base
  queue_as :default

  def perform(recursive)
    warmer = CacheWarmer.new
    result = warmer.warm(:wordpress_pages)
    result.save
  rescue => e
    Rails.logger.info e
  ensure
    CacheWarmerJob.perform_later(recursive)
  end
end
