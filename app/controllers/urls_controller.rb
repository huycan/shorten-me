class UrlsController < ApplicationController
  def show
    # cache

    # db
    url = Url.find_by!(code: params[:code])

    # enqueue for analytics


    redirect_to url.full_url
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
