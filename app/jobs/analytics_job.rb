class AnalyticsJob < ActiveJob::Base
  queue_as :default

  def perform url_id, request
    UrlVisit.create url_id: url_id, browser: Browser.new(request[:headers]["HTTP_USER_AGENT"]).name
  end
end
