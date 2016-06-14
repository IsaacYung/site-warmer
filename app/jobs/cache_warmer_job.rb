class CacheWarmerJob < ActiveJob::Base
  queue_as :default

  def perform(url)
    warmer = CacheWarmer.new
    warmer.warm(url)
  end
end
