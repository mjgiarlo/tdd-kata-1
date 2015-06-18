require "string_calculator/tokenizer"
require "string_calculator/adder"

module StringCalculator
  class Base
    def add(string)
      addends = Tokenizer.new(string).call { |token| token.map(&:to_i) }
      Adder.new(addends).call
    end
  end
end
