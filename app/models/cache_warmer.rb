class CacheWarmer
  UAS = [Requester::DESKTOP, Requester::MOBILE, Requester::TABLET]

  def warm
    start_time = Time.now
    requester = Requester.new

    warm_result = WarmResult.new(entry_point: entrypoint)

    urls.each_with_index do |url, i|
      Rails.logger.info "GET #{url} (#{i.percent_of(urls.length)}% done)"

      UAS.each do |ua|
        response = requester.get(url, ua)
        warm_result.cold_urls.build(user_agent: ua, url: url) if cold?(response)
      end
    end

    warm_result.duration = Time.now - start_time
    warm_result.total_urls = urls.length

    warm_result
  end

  private

  def urls
    @urls ||= build_urls
  end

  def entrypoint
    result = []
    result << 'sitemap' if SiteMap.enabled?
    result << 'wordpress' if Wordpress.enabled?
    result.join(',')
  end

  def build_urls
    urls = []

    if SiteMap.enabled?
      urls += SiteMap::Loader.new(SiteMap.url).urls
    end

    if Wordpress.enabled?
      urls += Wordpress::Loader.urls
    end

    urls.uniq
  end

  def cold?(response)
    response['cf-cache-status'] != 'HIT'
  end
end
