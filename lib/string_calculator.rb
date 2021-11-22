# frozen_string_literal: true

require 'string_calculator/policy'
require 'string_calculator/tokenizer'
require 'string_calculator/validator'

# Does what it says on the tin
class StringCalculator
  def add(string)
    Tokenizer
      .tokenize(string)
      .then { |tokens| tokens.map(&:to_i) }
      .then { |integers| Validator.validate(integers) }
      .then { |valid_integers| Policy.allow(valid_integers) }
      .then(&:sum)
  end
end
