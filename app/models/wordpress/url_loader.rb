module Wordpress
  class UrlLoader
    def self.load
      posts_urls + redirects
    end

    def self.posts_urls
      posts = Wordpress::Post.all
      posts.map(&:full_path)
    end

    def self.redirects
      []
    end
  end
end
