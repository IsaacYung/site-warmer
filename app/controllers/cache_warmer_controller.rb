class CacheWarmerController < ApplicationController
  def create
    if sitemap_url.present?
      CacheWarmerJob.perform_later(sitemap_url)
    else
      Rails.logger.warn 'Sitemap url not provided'
    end

    head :ok
  end

  private

  def sitemap_url
    @sitemap_url ||= params[:sitemap_url]
  end
end
