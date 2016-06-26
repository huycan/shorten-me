class Url < ActiveRecord::Base
  def shorten base_url
    "#{ base_url }/#{ self[:code] }"
  end

  def encode!
    self[:code] = encode self[:id]
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
