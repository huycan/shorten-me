class AnalyticsJob < ActiveJob::Base
  queue_as :default

  def perform url_id, request
  end
end
