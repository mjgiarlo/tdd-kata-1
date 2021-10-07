# frozen_string_literal: true

require_relative './delimiter_finder'

module StringCalculator
  class Tokenizer
    def self.tokenize(string, delimiter_finder_class = DelimiterFinder)
      new(string, delimiter_finder_class).tokenize
    end

    attr_reader :delimiters, :tokens

    def initialize(string, delimiter_finder_class)
      @delimiters = delimiter_finder_class.find(string)
      @tokens = string.split(delimited_regex)
    end

    def tokenize
      tokens.map(&:to_i)
    end

    private

    def delimited_regex
      Regexp.new(delimiters.map { |delim| Regexp.escape(delim) }.join('|'))
    end
  end
end
