# frozen_string_literal: true

class StringCalculator
  # Add a bunch of integers
  class Adder
    def self.add(addends)
      new(addends).add
    end

    attr_accessor :addends

    def initialize(addends)
      @addends = addends.reject { |addend| addend > maximum_allowed_addend }
    end

    def add
      addends.sum
    end

    private

    def maximum_allowed_addend
      1000
    end
  end
end
