class CacheWarmerJob < ActiveJob::Base
  queue_as :default

  def perform(recursive=false)
    warmer = CacheWarmer.new
    result = warmer.warm
    result.save

    if recursive
      CacheWarmerJob.perform_later(true)
    end
  rescue => e
    Rails.logger.info e
    CacheWarmerJob.perform_later(recursive)
  end
end
