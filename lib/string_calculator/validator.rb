# frozen_string_literal: true

module StringCalculator
  class Validator
    def self.validate(tokens)
      new(tokens).validate
    end

    attr_accessor :tokens

    def initialize(tokens)
      @tokens = tokens
    end

    def validate
      tokens.partition { |token| token >= MINIMUM }.tap do |valid_tokens, invalid_tokens|
        return valid_tokens if invalid_tokens.empty?

        raise "negatives not allowed: #{invalid_tokens}"
      end
    end
  end
end
