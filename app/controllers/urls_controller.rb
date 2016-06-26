class UrlsController < ApplicationController
  def show
    redirect_to 'https://google.com'
  end

  def create
    huy = { url: 'shorten.me/urls/abcdef' }
    render json: huy
  end
end
