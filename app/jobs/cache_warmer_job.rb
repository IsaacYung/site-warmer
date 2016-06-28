class CacheWarmerJob < ActiveJob::Base
  queue_as :default

  def perform(url)
    warmer = CacheWarmer.new
    result = warmer.warm(url)
  end
end
