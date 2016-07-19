class CacheWarmerJob < ActiveJob::Base
  queue_as :default

  def perform(url, recursive=false)
    warmer = CacheWarmer.new
    result = warmer.warm(url)
    result.save

    if recursive
      CacheWarmerJob.perform_later(url, true)
    end
  rescue e
    CacheWarmerJob.perform_later(url, recursive)
  end
end
