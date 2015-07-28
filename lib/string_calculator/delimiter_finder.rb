module StringCalculator
  class DelimiterFinder
    attr_reader :string

    def initialize(string)
      @string = string
    end

    def call
      default_delimiters + extract_delimiters
    end

    private

      def default_delimiters
        ["\n", ","]
      end

      def extract_delimiters
        return [] unless string.match(%r{//.+\n})
        # Yeah, this part sucks because I lacked the regex fu to combine these
        if string.count('[') == 0
          string.match(%r{//\[?(.+?)\]?\n}).captures
        else
          string.scan(%r{\[(.+?)\]}).flatten
        end
      end
  end
end
