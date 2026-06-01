-- Coal removal
seablock.lib.substingredient("grenade", "coal", "angels-wood-charcoal")
seablock.lib.substingredient("explosives", "coal", "angels-wood-charcoal")
seablock.lib.substingredient("bob-solid-fuel-from-hydrogen", "coal", "angels-wood-charcoal")
if mods["bobenemies"] then
  seablock.lib.substingredient("bob-alien-poison", "coal", "angels-wood-charcoal")
  seablock.lib.substingredient("bob-alien-explosive", "coal", "angels-wood-charcoal")
end
seablock.lib.substingredient("angels-filter-coal", "coal", "angels-wood-charcoal")
-- Bob's dev branch renamed the carbon item/recipe from "bob-carbon" to the
-- Factorio 2.0-style "carbon".  Angel's petrochem override will later replace
-- the recipe result with "angels-solid-carbon"; Sea Block still needs to swap
-- the coal ingredient here so carbon production fits the no-natural-coal start.
seablock.lib.substingredient("carbon", "coal", "angels-wood-charcoal")
if mods["Transport_Drones"] then
  seablock.lib.substingredient("road", "coal", "angels-wood-charcoal")
end
seablock.lib.substingredient("angels-gas-carbon-dioxide", "coal", "angels-wood-charcoal", 1)
if mods["angelsaddons-storage"] and data.raw.recipe["angels-silo-coal"] then
  seablock.lib.substingredient("angels-silo-coal", "angels-coal-crushed", "angels-wood-charcoal", 10)
end

-- Disable coal cracking technology
seablock.lib.hide_technology("angels-coal-cracking")
seablock.lib.moveeffect("angels-pellet-coke", "angels-coal-processing-3", "angels-coal-processing-2")
angelsmods.functions.move_item("angels-pellet-coke", "angels-bio-processing-wood", "f[pellet-coke]")
angelsmods.functions.move_item("angels-pellet-coke", "angels-bio-processing-wood", "f[pellet-coke]", "recipe")
data.raw.recipe["angels-pellet-coke"].localised_name = { "item-name.angels-pellet-charcoal" }

-- Clear fuel value so these don't appear in Helmod's fuel picker
-- The hidden Bob carbon item can remain present as "carbon" even when Angel's
-- recipes prefer "angels-solid-carbon".  Guard the lookup so future Bob/Angel
-- load-order changes do not turn an optional hidden item into a startup crash.
local bob_carbon_item = data.raw.item["carbon"]
if bob_carbon_item then
  bob_carbon_item.fuel_emissions_multiplier = nil
  bob_carbon_item.fuel_value = nil
  bob_carbon_item.fuel_category = nil
end
data.raw.item["coal"].fuel_emissions_multiplier = nil
data.raw.item["coal"].fuel_value = nil
data.raw.item["coal"].fuel_category = nil
data.raw.item["angels-coal-crushed"].fuel_value = nil
data.raw.item["angels-coal-crushed"].fuel_category = nil

-- Move charcoal processing 3 to purple science
-- Sodium carbonate is unusable before then
bobmods.lib.tech.add_science_pack("angels-coal-processing-3", "chemical-science-pack", 1)
bobmods.lib.tech.add_science_pack("angels-coal-processing-3", "production-science-pack", 1)
bobmods.lib.tech.remove_prerequisite("angels-sodium-processing-2", "angels-coal-processing-3")
bobmods.lib.tech.add_prerequisite("angels-coal-processing-3", "angels-sodium-processing-2")

-- Buff the Carbon 2 recipe to make it a bit more worthwhile
bobmods.lib.recipe.set_result("angels-coke-purification-2", { type = "item", name = "angels-solid-carbon", amount = 8 })

data.raw.recipe["angels-filter-coal"].localised_name = { "item-name.angels-filter-charcoal" }
