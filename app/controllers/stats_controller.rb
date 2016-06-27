class StatsController < ApplicationController
  def show
    @code = params[:code]
    @hits = UrlVisit.hits @code
    @daily = UrlVisit.daily_report @code
    @browser = UrlVisit.brower_report @code

    p @daily, @browser
  end
end
