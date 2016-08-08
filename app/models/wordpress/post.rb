module Wordpress
  class Post < ActiveRecord::Base
    establish_connection :"wordpress_#{Rails.env}"
    self.table_name = 'wp_posts'

    def self.all
      @posts ||= Wordpress::Post
                 .find_by_sql('select ID, post_name, post_parent from wp_posts' \
                              ' where post_status = "publish"')
    end

    def self.posts_map
      @map ||= build_post_map
    end

    def self.build_post_map
      map = {}
      all.each { |v| map[v.ID] = v }
      map
    end

    def full_path
      path_data = []
      current = self

      while current
        path_data.unshift(current.post_name)
        current = Wordpress::Post.posts_map[current.post_parent]
      end

      "/#{path_data.join('/')}"
    end
  end
end
