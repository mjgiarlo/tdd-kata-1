# frozen_string_literal: true

class StringCalculator
  # Validate a set of tokens
  class Validator
    def self.validate(tokens)
      new(tokens).validate
    end

    attr_accessor :tokens

    def initialize(tokens)
      @tokens = tokens
    end

    def validate
      tokens.partition(&:negative?).tap do |invalid_tokens, valid_tokens|
        invalid_tokens.any? { |_| raise "negatives not allowed: #{invalid_tokens}" }

        return valid_tokens
      end
    end
  end
end
