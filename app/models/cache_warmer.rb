class CacheWarmer
  def warm(sitemap_url)
    start_time = Time.now
    urls = SiteMap.new(sitemap_url).urls

    requester = Requester.new

    warm_result = WarmResult.new
    warm_result.entry_point = sitemap_url

    urls.each_with_index do |url, i|
      Rails.logger.info "GET #{url} (#{i.percent_of(urls.length)}% done)"
      response = requester.get(url)
      warm_result.append_cold_url(url) if cold?(response)
    end

    warm_result.duration = Time.now - start_time
    warm_result.total_urls = urls.length

    warm_result
  end

  private

  def cold?(response)
    response['cf-cache-status'] != 'HIT'
  end
end
