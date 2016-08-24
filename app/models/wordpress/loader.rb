module Wordpress
  class Loader
    def self.urls
      posts = add_slash(Wordpress::Post.all.map(&:to_s))
      terms = add_slash(Wordpress::Term.all.map(&:to_s))

      with_domain(['/robots.txt', '/', '/sitemap.xml'] + posts + terms)
    end

    def self.redirects
      with_domain(Wordpress::Option.yoast_redirects)
    end

    def self.specials
      ['/robots.txt', '/', '/sitemap.xml']
    end

    def self.add_slash(urls)
      new_urls = []
      urls.each do |u|
        new_urls << u + '/' unless u.ends_with?('/')
      end
      new_urls += urls
    end

    def self.with_domain(urls)
      urls.map do |obj|
        url = obj.to_s
        if url[0..3] == 'http'
          url
        else
          Wordpress::Option.domain + url
        end
      end
    end
  end
end
