class WarmResult < ActiveRecord::Base
  def append_cold_url(url)
    self.cold_urls ||= []
    self.cold_urls << url
  end
end
