class CacheWarmer
  def warm(sitemap_url)
    start_time = Time.now
    Rails.logger.info 'Starting cacher'

    urls = SiteMap.new(sitemap_url).urls
    Rails.logger.info "#{urls.length} found, starting requests..."

    requester = Requester.new
    urls.each_with_index do |url, i|
      Rails.logger.info "GET #{url} (#{i.percent_of(urls.length)}% done)"
      requester.get(url)
    end

    Rails.logger.info 'Job completed, ' \
                      "#{Time.now - start_time} seconds elapsed"
  end
end
