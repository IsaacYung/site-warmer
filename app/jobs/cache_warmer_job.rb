class CacheWarmerJob < ActiveJob::Base
  queue_as :default

  def perform(url, recursive=false)
    warmer = CacheWarmer.new
    result = warmer.warm(url)
    result.save

    if recursive
      CacheWarmerJob.set(wait: 20.minutes).perform_later(url, true)
    end
  end
end
