class CacheWarmer
  def warm(sitemap_url)
    start_time = Time.now
    urls = SiteMap::Loader.new(sitemap_url).urls

    requester = Requester.new

    warm_result = WarmResult.new
    warm_result.entry_point = sitemap_url

    urls.each_with_index do |url, i|
      Rails.logger.info "GET #{url} (#{i.percent_of(urls.length)}% done)"

      response_desktop = requester.get(url, Requester::DESKTOP)
      response_mobile = requester.get(url, Requester::MOBILE)
      response_tablet = requester.get(url, Requester::TABLET)

      warm_result.append_cold_desktop_url(url) if cold?(response_desktop)
      warm_result.append_cold_mobile_url(url) if cold?(response_mobile)
      warm_result.append_cold_tablet_url(url) if cold?(response_tablet)
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
