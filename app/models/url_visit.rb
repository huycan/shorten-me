class UrlVisit < ActiveRecord::Base
  belongs_to :url

  def self.hits code
    by(code).count
  end

  def self.daily_report code
    by(code).where('created_at >= ?', 1.week.ago).group("DATE(created_at)").count
  end

  def self.brower_report code
    by(code).group('browser').count
  end

  private
  def self.from code
    Url.find_by code: code
  end

  def self.by code
    UrlVisit.where url_id: from(code).id
  end
end
