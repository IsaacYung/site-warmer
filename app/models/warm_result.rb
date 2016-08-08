class WarmResult < ActiveRecord::Base
  def append_cold_desktop_url(url)
    self.cold_urls ||= []
    self.cold_urls << url
  end

  def append_cold_mobile_url(url)
    self.cold_mobile_urls ||= []
    self.cold_mobile_urls << url
  end

  def append_cold_tablet_url(url)
    self.cold_tablet_urls ||= []
    self.cold_tablet_urls << url
  end
end
