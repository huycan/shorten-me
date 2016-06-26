class UrlsController < ApplicationController
  def show
    url = Url.from params[:code]

    # enqueue for analytics
    

    redirect_to url.full_url
  end

  def create
    url = Url.find_or_new params[:url]
    render json: { url: url.shorten(base_url) }
  end

  private
  def base_url
    "#{ request.base_url }/urls"
  end
end
