class Url < ActiveRecord::Base
  def shorten base_url
    "#{ base_url }/#{ self[:code] }"
  end

  def encode!
    self[:code] = encode self[:id]
  end

  def self.from code
    url = Rails.cache.fetch("#{ code }", expires_in: 60.days) do
      Url.find_by! code: code
    end

    url
  end

  def self.find_or_new original_url
    url = Url.find_or_create_by full_url: original_url
    url.encode! and url.save if url.code.blank?
    url
  end

  private
  def encode id
    NumberConversionService.new.convert id
  end
end
