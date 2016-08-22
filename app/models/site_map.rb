module SiteMap
  def self.enabled?
    ENV['SITEMAP'].present?
  end

  def self.url
    ENV['SITEMAP']
  end
end
