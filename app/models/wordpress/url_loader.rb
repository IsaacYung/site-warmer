module Wordpress
  class UrlLoader
    def self.load
      (posts_urls + redirects + terms + specials).map do |obj|
        url = obj.to_s
        if url[0..3] == 'http'
          url
        else
          Wordpress::Option.domain + url
        end
      end
    end

    def self.posts_urls
      Wordpress::Post.all
    end

    def self.redirects
      Wordpress::Option.redirects
    end

    def self.terms
      Wordpress::Term.all
    end

    def self.specials
      ['/robots.txt', '/', '/sitemap.xml']
    end
  end
end
