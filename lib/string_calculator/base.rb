require 'string_calculator/adder'
require 'string_calculator/tokenizer'
require 'string_calculator/validator'

module StringCalculator
  MINIMUM = 0
  MAXIMUM = 1000

  class Base
    def add(string)
      Tokenizer.tokenize(string)
        .then { |tokens| Validator.validate(tokens) }
        .then { |addends| Adder.add(addends) }
    end
  end
end
