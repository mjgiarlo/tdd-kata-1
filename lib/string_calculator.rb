require "string_calculator/version"

module StringCalculator
  class DelimiterFinder
    attr_reader :string

    def initialize(string)
      @string = string
    end

    def call
      defaults.tap { |delims| delims.concat(extract_delimiters) }.compact
    end

    private

      def defaults
        ["\n", ","]
      end

      def extract_delimiters
        return [] unless string.match(%r{//.+\n})
        # Yeah, this part sucks because I lacked regex fu to combine these exps
        if string.count('[') == 0
          string.match(%r{//\[?(.+?)\]?\n}).captures
        else
          string.scan(%r{\[(.+?)\]}).flatten
        end
      end
  end

  class Tokenizer
    attr_reader :string, :delimiters

    def initialize(string, delimiter_finder_class = ::StringCalculator::DelimiterFinder)
      @string = string
      @delimiters = delimiter_finder_class.new(string).call
    end

    def call
      string.split(delimited_regex)
    end

    private

      def delimited_regex
        Regexp.new(delimiters.map { |delim| Regexp.escape(delim) }.join('|'))
      end
  end

  class Adder
    attr_reader :addends

    def initialize(addends)
      @addends = addends
      validate_addends
      filter_addends
    end

    def call
      addends.reduce(0) { |sum, token| sum + token }
    end

    private

      def validate_addends
        negatives = addends.select { |addend| addend < 0 }
        return if negatives.empty?
        raise RuntimeError.new("negatives not allowed: #{negatives}")
      end

      def filter_addends
        @addends = addends.reject { |addend| addend > 1000 }
      end
  end

  class StringCalculator
    def add(string)
      tokens = ::StringCalculator::Tokenizer.new(string).call
      addends = tokens.map(&:to_i)
      sum = ::StringCalculator::Adder.new(addends).call
    end
  end
end
