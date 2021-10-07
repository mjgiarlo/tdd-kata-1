# frozen_string_literal: true

module StringCalculator
  class Adder
    def self.add(addends)
      new(addends).add
    end

    attr_accessor :addends

    def initialize(addends)
      @addends = addends.reject { |addend| addend > MAXIMUM }
    end

    def add
      addends.sum
    end
  end
end
