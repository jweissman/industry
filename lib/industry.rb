require 'industry/version'
require 'industry/material'
require 'industry/material_account'
require 'industry/operation'
require 'industry/machine'
require 'industry/environment'
require 'industry/report'
require 'industry/dsl'

module Industry
  extend DSL

  Nothing        = material 'Vacuum'
  Heat           = material 'Heat'
  FreshAir       = material 'Fresh Air'
  Soil           = material 'Soil'
  Fertilizer     = material 'Fertilizer'
  OrganicWaste   = material 'Organic Waste'
  Vegetables     = material 'Fresh Veggies'
  Wood           = material 'Wood'
  Lumber         = material 'Lumber'
  Timber         = material 'Timber'
  Labor          = material 'Labor'
  Water          = material 'Water'
  Knowledge      = material 'Knowledge'
  # Grapes         = matieral 'Grapes'
  # Fermentation = Operation.new(name: 'Fermentation', input: Grapes.demand(1), output: Wine.supply(3))

  Photosynthesis = operation 'Photosynthesis', Water.demand(1), FreshAir.supply(10)
  GrowOakwood    = operation 'Grow Oakwood', Water.demand(1), Wood.supply(1)
  Habitation     = operation 'Habitation',
    (Vegetables.demand(0.2) + Water.demand(1)),
    (Labor.supply(1) + OrganicWaste.supply(1))

  Decomposition  = operation "Decomposition", OrganicWaste.demand(1), (Fertilizer.supply(3) + FreshAir.demand(1))

  Logging        = operation 'Logging', Wood.demand(1), Timber.supply(1)
  Sawing         = operation 'Sawyering', Timber.demand(1), Lumber.supply(1)
  Incineration   = operation 'Incinerate', Wood.demand(1), (Heat.supply(1) + FreshAir.demand(1))
  Farming        = operation 'Farming', Fertilizer.demand(1), Vegetables.supply(20)
  DrawWater      = operation 'Draw Water', Nothing.demand(0), Water.supply(1)

  Research = operation "Research", Labor.demand(1), Knowledge.supply(10)

  Well      = machine 'Well', DrawWater
  Sawmill   = machine 'Sawmill', Logging, Sawing, Incineration
  Windmill  = machine "Windmill", Farming
  Compost   = machine 'Compost',  Decomposition
  House     = machine 'Small Dwelling', Habitation
  Tree      = machine 'Tree', Photosynthesis, GrowOakwood
  OakGrove  = machine 'Strand of Oaks', Photosynthesis, GrowOakwood

  Laboratory = machine "Laboratory", Research

  # not frozen, since it will move..
  Universe  = Environment.new(
    machines: [ Tree, OakGrove, Well, House, Windmill, Sawmill, Compost, Laboratory ],
    inventory: Soil.supply(1e6) + Water.supply(1e6) # + Light.supply(1e6)
  )
end
