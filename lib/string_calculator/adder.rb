module StringCalculator
  class Adder
    attr_accessor :addends

    def initialize(addends)
      @addends = addends
      filter!
      validate!
    end

    def call
      addends.reduce(0) { |sum, token| sum + token }
    end

    private

      def filter!
        addends.reject! { |addend| addend > maximum }
      end

      def validate!
        negatives = addends.select { |addend| addend < minimum }
        return if negatives.empty?
        raise RuntimeError, "negatives not allowed: #{negatives}"
      end

      def minimum
        0
      end

      def maximum
        1000
      end
  end
end
