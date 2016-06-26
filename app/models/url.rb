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
  def code_map
    [*('a'..'z'), *('A'..'Z'), *('0'..'9')]
  end

  def convert number, base
    code = []

    while number > 0
      remainder = number % base
      number = number / base
      code << remainder
    end

    code
  end

  def encode id
    codes = code_map
    
    code = convert id, codes.length
    
    (code.reverse.map { |digit| codes[digit] }).join
  end
end
