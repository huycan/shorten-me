class Url < ActiveRecord::Base
  def shorten base_url
    "#{ base_url }/#{ self[:code] }"
  end

  def encode!
    self[:code] = encode self[:id], self[:full_url]
  end

  private
  def encode id, full_url
    code_map = [*('a'..'z'), *('A'..'Z'), *('0'..'9')]
    base = code_map.length
    code = []

    while id > 0
      remainder = id % base
      id = id / base
      code << remainder
    end

    code.reverse.map { |digit| digit.to_s }
    code.join
  end
end
