module Wordpress
  class Option < ActiveRecord::Base
    establish_connection :"wordpress_#{Rails.env}"
    self.table_name = 'wp_options'

    def self.redirects
      Rails.cache.fetch('redirects', expires_in: 1.minute) do
        redirects = Wordpress::Option
                      .find_by_sql('select option_value from wp_options where' \
                                   ' option_name = "wpseo-premium-redirects"')
                      .first
                      .option_value

        PHP::unserialize(redirects).keys
      end
    end
  end
end
