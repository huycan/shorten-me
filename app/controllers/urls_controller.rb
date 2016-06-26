class UrlsController < ApplicationController
  def show
    full_url = Rails.cache.fetch("urls/#{ params[:code] }", expires_in: 60.days) do
      (Url.find_by! code: params[:code]).full_url
    end

    # enqueue for analytics
    

    redirect_to full_url
  end

  def create
    url = Url.find_or_create_by full_url: params[:url]
    url.encode! and url.save if url.code.blank?
    render json: { url: url.shorten(base_url) }
  end

  private
  def base_url
    "#{ request.base_url }/urls"
  end
end
