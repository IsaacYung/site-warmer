module Wordpress
  class UrlLoader
    def self.load
      (posts_urls + redirects).map do |url|
        if url[0..3] == 'http'
          url
        else
          Wordpress::Option.domain + url
        end
      end
    end

    def self.posts_urls
      posts = Wordpress::Post.all
      posts.map(&:full_path)
    end

    def self.redirects
      Wordpress::Option.redirects
    end
  end
end
