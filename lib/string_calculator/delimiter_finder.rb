# frozen_string_literal: true

class StringCalculator
  # Find delimiters in a string
  class DelimiterFinder
    def self.find(string)
      new(string).find
    end

    attr_reader :string

    def initialize(string)
      @string = string
    end

    def find
      default_delimiters + extract_delimiters
    end

    private

    def default_delimiters
      ["\n", ',']
    end

    def extract_delimiters
      string.scan(%r{
        (?<=\[).+?(?=\])+ # Match one or more multi-character delimiters in brackets
        |                 # ... or ...
        (?<=//)[^\[]?     # Match a single non-bracket character after two forward slashes
      }x)
    end
  end
end
