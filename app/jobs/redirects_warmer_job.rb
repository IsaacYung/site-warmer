class RedirectsWarmerJob < ActiveJob::Base
  queue_as :redirects

  def perform(recursive)
    warmer = CacheWarmer.new
    result = warmer.warm(:wordpress_redirects)
    result.save

    if recursive
      RedirectsWarmerJob.perform_later(true)
    end
  rescue => e
    Rails.logger.info e
    RedirectsWarmerJob.perform_later(recursive)
  end
end
