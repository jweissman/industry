module Industry
  class Machine
    attr_reader :name, :cycle
    def initialize(name:, operations: [], cycle: 1e2)
      @name = name
      @operations = operations
      @cycle = cycle
    end

    def operate
      @operations.map(&:perform).inject(&:+)
    end

    def describe
      operate.demands.to_a.map(&:first).map(&:name).join(', ') +
        " -> " +
        operate.supplies.to_a.map(&:first).map(&:name).join(', ')
    end

    class << self
      def base_cycle
        1e4
      end

      def half_speed
        base_cycle / 2
      end

      def double_speed
        base_cycle * 2
      end
    end
  end
end
