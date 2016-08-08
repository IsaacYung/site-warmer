require 'rexml/document'
require 'open-uri'

module SiteMap
  class Loader
    def initialize(site_map_url)
      Rails.logger.info "Loading sitemap #{site_map_url}"
      xml_body = open(site_map_url).read
      @xml = REXML::Document.new(xml_body)
    end

    def urls
      return @urls if @urls.present?

      urls = REXML::XPath.match(@xml, '//url/loc').map(&:text)

      REXML::XPath.match(@xml, '//sitemap/loc').each do |s|
        subsitemap = SiteMap.new(s.text)
        urls += subsitemap.urls
      end

      @urls = urls.uniq
    end
  end
end
