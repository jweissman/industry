module Industry
  class Environment
    attr_reader :steps, :machines, :inventory
    def initialize(machines: [], inventory: Wood.supply(0))
      @machines = machines
      @inventory = inventory
    end

    def simulate!
      step until done?
    end

    def report_cycle
      1e3
    end

    def step
      @steps ||= 0; @steps += 1
      report if @steps % report_cycle == 0
      iterate
    end

    def report
      Report.new(self).display
    end

    def iterate
      @machines.each do |machine|
        if @steps % machine.cycle == 0
          @inventory += machine.operate
        end
      end
    end

    def done?
      @steps && @steps >= 1e5
    end
  end
end
