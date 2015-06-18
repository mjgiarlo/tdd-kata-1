require_relative "./delimiter_finder"

module StringCalculator
  class Tokenizer
    attr_reader :string, :delimiters

    def initialize(string, delimiter_finder_class = DelimiterFinder)
      @string = string
      @delimiters = delimiter_finder_class.new(string).call
    end

    def call
      if block_given?
        yield tokens
      else
        tokens
      end
    end

    private

      def tokens
        string.split(delimited_regex)
      end

      def delimited_regex
        Regexp.new(delimiters.map { |delim| Regexp.escape(delim) }.join('|'))
      end
  end
end
