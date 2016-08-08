module Wordpress
  class Term < ActiveRecord::Base
    establish_connection :"wordpress_#{Rails.env}"
    self.table_name = 'wp_terms'

    TAXONOMY_PATHS = {
      'help-center' => 'central-de-ajuda',
      'category' => 'blog/category',
      'post_tag' => 'blog/tag'
    }.freeze

    def self.all
      @all ||= Wordpress::Term
                 .find_by_sql('select tax.taxonomy, term.slug ' \
                                'from wp_terms term ' \
                                'inner join wp_term_taxonomy tax ' \
                                'on term.term_id = tax.term_id ' \
                                'where tax.taxonomy not in("nav_menu")')
    end

    def to_s
      '/' + [TAXONOMY_PATHS[taxonomy], slug].join('/') + '/'
    end
  end
end
