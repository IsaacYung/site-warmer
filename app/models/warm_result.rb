class WarmResult < ActiveRecord::Base
  has_many :cold_urls
end
