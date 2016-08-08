module Wordpress
  def self.enabled?
    Wordpress::Post.connection.present?
  rescue
    false
  end
end
