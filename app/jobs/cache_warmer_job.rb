class CacheWarmerJob < ActiveJob::Base
  queue_as :default

  rescue_from(OpenSSL::SSL::SSLError) do
    retry_job queue: :default
  end

  def perform(url, recursive=false)
    warmer = CacheWarmer.new
    result = warmer.warm(url)
    result.save

    if recursive
      CacheWarmerJob.perform_later(url, true)
    end
  end
end
