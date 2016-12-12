module Industry
  module DSL
    def material(name)
      Material.new(name: name).freeze
    end

    def operation(name, input, output) #: Nothing.demand(0), output: Nothing.supply(0))
      Operation.new(name: name, input: input, output: output).freeze
    end

    def machine(name, *operations)
      Machine.new(name: name, operations: operations).freeze
    end
  end
end
