# frozen_string_literal: true

class StringCalculator
  # Validate a set of tokens
  class Validator
    def self.validate(integers)
      new(integers).validate
    end

    attr_accessor :integers

    def initialize(integers)
      @integers = integers
    end

    def validate
      integers.partition(&:negative?).tap do |invalid_integers, valid_integers|
        invalid_integers.any? do |_|
          raise "negatives not allowed: #{invalid_integers}"
        end

        return valid_integers
      end
    end
  end
end
