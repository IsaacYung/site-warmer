module Wordpress
  class Loader
    def self.urls
      posts = add_slash(Wordpress::Post.all.map(&:to_s))
      terms = add_slash(Wordpress::Term.all.map(&:to_s))
      redirects = Wordpress::Option.yoast_redirects

      (specials + posts + redirects + terms).map do |obj|
        url = obj.to_s
        if url[0..3] == 'http'
          url
        else
          Wordpress::Option.domain + url
        end
      end
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
  end
end
