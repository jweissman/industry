module Industry
  class Material
    attr_reader :name

    def initialize(name:)
      @name = name
    end

    def supply(n)
      MaterialAccount.new.supply(self, n)
    end

    def demand(n)
      MaterialAccount.new.demand(self, n)
    end

    def to_s; @name; end
  end
end
