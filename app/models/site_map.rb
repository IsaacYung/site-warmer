module SiteMap
  def self.enabled?
    ENV['SITEMAP'].present?
  end
end
