class NumberConversionService
  attr_reader :codes, :base

  def initialize codes = nil
    @codes = [*('a'..'z'), *('A'..'Z'), *('0'..'9')] if codes.nil? else codes
    @base = @codes.length

    @codes.freeze
    @base.freeze
  end

  def convert number
    code = []

    while number > 0
      remainder = number % base
      number = number / base
      code << remainder
    end

    transform_base_10 code.reverse
  end

  def transform_base_10 digits
    (digits.map { |digit| codes[digit] }).join
  end
end