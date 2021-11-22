# frozen_string_literal: true

class StringCalculator
  # Filter list to only allowed members
  class Policy
    def self.allow(integers)
      new(integers).allow
    end

    attr_accessor :integers

    def initialize(integers)
      @integers = integers
    end

    def allow
      integers.select { |integer| integer < upper_bound }
    end

    private

    def upper_bound
      1001
    end
  end
end
