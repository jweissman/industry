module Industry
  class Operation
    attr_reader :input, :output

    def initialize(name:, input:, output:)
      @name = name
      @input = input
      @output = output
    end

    def perform
      @input + @output
    end

    def inspect; "#@name (#{perform})" end
  end
end
