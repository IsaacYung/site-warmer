class CacheWarmerJob < ActiveJob::Base
  queue_as :default

  def perform(url)
    warmer = CacheWarmer.new
    result = warmer.warm(url)

    notifier = Notifier.new(result)
    notifier.notify_slack
  end
end
