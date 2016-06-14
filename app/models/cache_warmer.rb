class CacheWarmer
  def warm(sitemap_url)
    start_time = Time.now
    urls = SiteMap.new(sitemap_url).urls

    requester = Requester.new
    urls.each_with_index do |url, i|
      Rails.logger.info "GET #{url} (#{i.percent_of(urls.length)}% done)"
      requester.get(url)
    end

    result = WarmResult.new
    result.entry_point = sitemap_url
    result.duration = Time.now - start_time
    result.total_urls = urls.length

    result
  end
end
