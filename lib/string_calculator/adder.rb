module StringCalculator
  class Adder
    attr_accessor :addends

    def initialize(addends)
      @addends = filter(addends)
      validate
    end

    def call
      addends.reduce(0) { |sum, token| sum + token }
    end

    private

      def validate
        negatives = addends.select { |addend| addend < 0 }
        return if negatives.empty?
        raise RuntimeError.new("negatives not allowed: #{negatives}")
      end

      def filter(addends)
        addends.reject { |addend| addend > 1000 }
      end
  end
end
