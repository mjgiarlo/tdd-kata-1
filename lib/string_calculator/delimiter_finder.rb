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
end
