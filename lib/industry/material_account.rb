module Industry
  class MaterialAccount
    attr_reader :materials_registry

    def initialize(registry: {})
      @materials_registry = registry
    end

    def demands
      @materials_registry.select do |k,v|
        v < 0
      end
    end

    def supplies
      @materials_registry.select do |k,v|
        v > 0
      end
    end


    def each(&blk); @materials_registry.each(&blk) end

    def demand(material, amount)
      @materials_registry[material] ||= 0
      @materials_registry[material] -= amount
      self
    end

    def supply(material, amount)
      @materials_registry[material] ||= 0
      @materials_registry[material] += amount
      self
    end

    def materials
      @materials_registry.keys
    end

    def to_a
      @materials_registry.to_a.map do |material, amount|
        [ material.name, amount ]
      end
    end

    def +(other)
      new_registry = @materials_registry.merge(other.materials_registry) { |_,old,new| old + new }
      self.class.new(registry: new_registry)
    end

    def *(other)
      if other.is_a?(Numeric)
        self.class.new(registry: @materials_registry.inject({}) { |h, (k, v)| h[k] = v * other; h })
      else
        raise 'argument x in (material_account * x) must be a Fixnum!'
      end
    end
  end
end
