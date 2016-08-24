class RedirectsWarmerJob < ActiveJob::Base
  queue_as :redirects

  def perform(recursive)
    warmer = CacheWarmer.new
    result = warmer.warm(:wordpress_redirects)
    result.save
  rescue => e
    Rails.logger.info e
  ensure
    CacheWarmerJob.perform_later(recursive)
  end
end
