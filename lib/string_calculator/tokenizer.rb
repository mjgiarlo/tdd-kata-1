# frozen_string_literal: true

require_relative './delimiter_finder'

class StringCalculator
  # Tokenize a string
  class Tokenizer
    def self.tokenize(string)
      new(string).tokenize
    end

    attr_reader :string

    def initialize(string)
      @string = string
    end

    def tokenize
      string.split(delimited_regex).map(&:to_i)
    end

    private

    def delimiters
      DelimiterFinder.find(string)
    end

    def delimited_regex
      /#{delimiters.map { |delim| Regexp.escape(delim) }.join('|')}/
    end
  end
end
