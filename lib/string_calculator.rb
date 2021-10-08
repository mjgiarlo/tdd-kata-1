# frozen_string_literal: true

require 'string_calculator/adder'
require 'string_calculator/tokenizer'
require 'string_calculator/validator'

# Does what it says on the tin
class StringCalculator
  MINIMUM = 0
  MAXIMUM = 1000

  def add(string)
    Tokenizer.tokenize(string)
             .then { |tokens| Validator.validate(tokens) }
             .then { |addends| Adder.add(addends) }
  end
end
