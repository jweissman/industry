require 'pastel'
module Industry
  class Report
    def initialize(env)
      @env = env
    end

    def pastel
      @pastel ||= Pastel.new
    end

    def display
      puts
      puts
      puts "================================================"
      puts
      puts
      puts
      puts pastel.yellow "   STEP " + pastel.bold(@env.steps)
      puts "   ---------------------------"
      puts
      puts
      puts
      puts

      puts
      puts "     " + pastel.bold("MACHINES:")
      puts

      @env.machines.each do |machine|
        puts "      - " + pastel.blue(machine.name) + " " + pastel.yellow("(#{machine.describe})")
      end

      puts
      puts "     " + pastel.bold("MATERIALS:")
      puts
      @env.inventory.each do |material, amount|
        if amount.to_i != 0 && amount.abs.to_i <= 1e4
          puts "      - #{pastel.white material.name}: #{colorize_amount amount.to_i}"
        end
      end
      puts
      puts
      puts
    end

    def colorize_amount(amt)
      if amt > 0 then pastel.green(amt) else pastel.red(amt) end
    end
  end
end

