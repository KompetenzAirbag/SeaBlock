if data.raw.item["wind-turbine-2"] then
  seablock.lib.substingredient("wind-turbine-2", "iron-plate", "steel-plate", 3)
  bobmods.lib.recipe.enabled("wind-turbine-2", false)
  bobmods.lib.tech.add_recipe_unlock("steel-processing", "wind-turbine-2")
end

-- No natural gas, use methane for manganese pellet smelting
seablock.lib.substingredient("pellet-manganese-smelting", "gas-natural-1", "gas-methane")
bobmods.lib.tech.remove_prerequisite("angels-manganese-smelting-3", "oil-gas-extraction")
bobmods.lib.tech.add_prerequisite("angels-manganese-smelting-3", "angels-advanced-gas-processing")

-- Remove steel's prerequiste on Chemical processing 1
bobmods.lib.tech.remove_prerequisite("steel-processing", "chemical-processing-1")

-- Move Water Treatment from Electronics to Slag Processing 1. Hydro Plant no longer requires Green Circuits
-- Slag Processing 1 is first source of Sulfuric Waste Water
bobmods.lib.tech.remove_prerequisite("water-treatment", "angels-fluid-control")
bobmods.lib.tech.add_prerequisite("water-treatment", "slag-processing-1")

-- Allow skipping of waste water recycling
bobmods.lib.tech.remove_prerequisite("water-washing-1", "water-treatment")
bobmods.lib.tech.add_prerequisite("water-washing-1", "automation")
seablock.lib.moveeffect("yellow-waste-water-purification", "water-treatment-2", "water-treatment")

bobmods.lib.tech.remove_prerequisite("electronics", "chemical-processing-1")

bobmods.lib.recipe.set_category("liquid-fish-atmosphere", "chemistry")
seablock.lib.hide_technology("pumpjack")

if not seablock.trigger.mining_productivity then
  for i = 1, 4, 1 do
    if data.raw.technology["mining-productivity-" .. i] then
      seablock.lib.hide_technology("mining-productivity-" .. i)
      data.raw.technology["mining-productivity-" .. i].effects = {}
    end
  end
end

-- Remove resources so mining recipes don't show in FNEI
-- Have to leave at least one resource or game will not load
for k, v in pairs(data.raw["resource"]) do
  -- Sea-pump-resource is a virtual resource.
  -- When the offshore pump is placed, it is supposed to be replaced by the resource and a mining-drill.
  -- Removing the resource causes placement of heavy pumps to crash new maps.
  if k ~= "sea-pump-resource" then
    data.raw["resource"][k] = nil
  end
end

-- Add prerequisite for Tin and Lead
--bobmods.lib.tech.add_prerequisite("logistics", "ore-crushing")

-- Tidy prerequisite for Brass
bobmods.lib.tech.remove_prerequisite("zinc-processing", "electrolysis-1")
bobmods.lib.tech.replace_prerequisite("battery-3", "zinc-processing", "angels-zinc-smelting-1")
if mods["bobpower"] then
  bobmods.lib.tech.replace_prerequisite("electric-pole-2", "zinc-processing", "angels-brass-smelting-1")
  bobmods.lib.tech.replace_prerequisite("electric-substation-2", "zinc-processing", "angels-brass-smelting-1")
end

-- Move recipes that shouldn't be unlocked at startup
if mods["bobenemies"] then
  seablock.lib.add_recipe_unlock("bio-processing-alien-3", "alien-artifact-red-from-small")
  seablock.lib.add_recipe_unlock("bio-processing-alien-3", "alien-artifact-yellow-from-small")
  seablock.lib.add_recipe_unlock("bio-processing-alien-3", "alien-artifact-orange-from-small")
  seablock.lib.add_recipe_unlock("bio-processing-alien-3", "alien-artifact-blue-from-small")
  seablock.lib.add_recipe_unlock("bio-processing-alien-3", "alien-artifact-purple-from-small")
  seablock.lib.add_recipe_unlock("bio-processing-alien-3", "alien-artifact-green-from-small")
  seablock.lib.add_recipe_unlock("bio-processing-alien-3", "alien-artifact-from-small")
end

bobmods.lib.tech.remove_prerequisite("tungsten-processing", "angels-nickel-smelting-1")

bobmods.lib.tech.remove_recipe_unlock("bio-arboretum-swamp-1", "solid-plastic")

-- Buff Lime filtering
seablock.lib.substingredient("filter-lime", "solid-lime", nil, 1)
data.raw.recipe["filter-lime"].energy_required = 1
data.raw.recipe["angels-sulfur-scrubber"].energy_required = 6

-- Make Long Inserters a startup tech
if data.raw.technology["logistics-0"] then
  bobmods.lib.tech.replace_prerequisite("long-inserters-1", "logistics", "logistics-0")
end

-- Adjust for handcrafting boards

-- Divide by 2
seablock.lib.substingredient("solid-alginic-acid", "algae-brown", nil, 5)
seablock.lib.substresult("solid-alginic-acid", "solid-alginic-acid", nil, 1)
data.raw.recipe["solid-alginic-acid"].energy_required = 5

-- Divide by 5
seablock.lib.substingredient("solid-wood-pulp", "cellulose-fiber", nil, 4)
seablock.lib.substingredient("solid-wood-pulp", "solid-alginic-acid", nil, 1)
seablock.lib.substresult("solid-wood-pulp", "solid-wood-pulp", nil, 4)
data.raw.recipe["solid-wood-pulp"].energy_required = 0.8

-- Tidy up ore silo prerequisites
if mods["angelsaddons-storage"] then
  bobmods.lib.tech.remove_prerequisite("ore-silos", "angels-coal-processing")
  bobmods.lib.tech.replace_prerequisite("ore-silos", "ore-crushing", "ore-advanced-crushing")
end

-- Logistic System prerequisite of Pink Science
if not data.raw.tool["advanced-logistic-science-pack"] then
  bobmods.lib.tech.add_prerequisite("logistic-system", "utility-science-pack")
end

-- Saline rebalance
seablock.lib.substingredient("solid-salt-dissolving", "solid-salt", nil, 15)
seablock.lib.substingredient("solid-salt-dissolving", "water-purified", "water", 1000)
seablock.lib.substresult("solid-salt-dissolving", "water-saline", nil, 1000)
data.raw.recipe["solid-salt-dissolving"].energy_required = 5

-- Add missing science packs

for _, v in pairs({
  "bio-processing-alien-3",
  "gem-processing-1",
  "gem-processing-2",
  "gem-processing-3",
  "geode-crystallization-1",
  "polishing",
}) do
  if data.raw.technology[v] then
    bobmods.lib.tech.add_new_science_pack(v, "chemical-science-pack", 1)
  end
end

bobmods.lib.tech.add_prerequisite("polishing", "chemical-science-pack")
bobmods.lib.tech.add_prerequisite("geode-crystallization-1", "chemical-science-pack")

if mods["bobrevamp"] and not mods["bobclasses"] then
  bobmods.lib.tech.add_new_science_pack("rtg", "production-science-pack", 1)
  bobmods.lib.tech.add_new_science_pack("rtg", "utility-science-pack", 1)
  bobmods.lib.tech.add_prerequisite("rtg", "utility-science-pack")
  bobmods.lib.tech.remove_prerequisite("rtg", "angels-coal-processing-3")
  bobmods.lib.tech.add_prerequisite("rtg", "sodium-processing-2")
end

-- Swap gold for platinum
seablock.lib.substingredient("processing-electronics", "angels-wire-platinum", nil, 20)
if mods["bobmodules"] then
  seablock.lib.substingredient("module-processor-board-3", "angels-wire-platinum", "angels-plate-platinum", nil)
end
bobmods.lib.tech.add_prerequisite("advanced-electronics-3", "angels-platinum-smelting-1")
seablock.lib.substresult("angelsore-pure-mix2-processing", "platinum-ore", nil, 2)
seablock.lib.substresult("angelsore9-crystal-processing", "platinum-ore", nil, 2)
-- Swap stiratite for crotinnium so all pure ores are used
seablock.lib.substingredient("angelsore-pure-mix2-processing", "angels-ore3-pure", "angels-ore4-pure", nil)

-- Unhide rocket part to make it easier to view recipes
if data.raw.recipe["rocket-part"] then
  angelsmods.functions.remove_flag("rocket-part", "hidden")
  local r = data.raw.recipe["rocket-part"]

  if r.normal then
    r.normal.hidden = false
    r.normal.hide_from_player_crafting = true
  end
  if r.expensive then
    r.expensive.hidden = false
    r.expensive.hide_from_player_crafting = true
  end
  if not r.normal and not r.expensive then
    r.hidden = false
    r.hide_from_player_crafting = true
  end
end

-- Buff bob's silicon and tungsten recipes
seablock.lib.substingredient("silicon-carbide", "silicon-powder", nil, 10)
seablock.lib.substingredient("silicon-carbide", "carbon", nil, 10)
data.raw.recipe["silicon-carbide"].result_count = 20

seablock.lib.substingredient("silicon-nitride", "silicon-powder", nil, 10)
seablock.lib.substingredient("silicon-nitride", "gas-nitrogen", nil, 130)
data.raw.recipe["silicon-nitride"].result_count = 10

seablock.lib.substingredient("tungsten-carbide", "tungsten-oxide", nil, 10)
seablock.lib.substingredient("tungsten-carbide", "carbon", nil, 10)
seablock.lib.substresult("tungsten-carbide", "tungsten-carbide", nil, 20)
bobmods.lib.recipe.set_energy_required("tungsten-carbide", 6)

seablock.lib.substingredient("tungsten-carbide-2", "powdered-tungsten", nil, 10)
seablock.lib.substingredient("tungsten-carbide-2", "carbon", nil, 10)
seablock.lib.substresult("tungsten-carbide-2", "tungsten-carbide", nil, 20)
bobmods.lib.recipe.set_energy_required("tungsten-carbide-2", 6)

seablock.lib.substingredient("copper-tungsten-alloy", "powdered-tungsten", nil, 15)
seablock.lib.substingredient("copper-tungsten-alloy", "copper-plate", "powder-copper", 10)
seablock.lib.substresult("copper-tungsten-alloy", "copper-tungsten-alloy", nil, 25)
bobmods.lib.recipe.set_energy_required("copper-tungsten-alloy", 8)
bobmods.lib.tech.add_prerequisite("tungsten-alloy-processing", "angels-copper-smelting-2")

-- Other prerequisites
if data.raw.technology["electronics-machine-1"] then
  bobmods.lib.tech.add_prerequisite("electronics-machine-1", "electronics")
end
bobmods.lib.tech.add_prerequisite("bio-pressing-1", "bio-nutrient-paste")

bobmods.lib.tech.add_prerequisite("resins", "automation-2")
bobmods.lib.tech.add_prerequisite("plastics", "automation-2")
if mods["boblogistics"] then
  bobmods.lib.tech.add_prerequisite("bob-repair-pack-2", "military")
end
bobmods.lib.tech.add_prerequisite("angels-advanced-chemistry-1", "fluid-handling")
bobmods.lib.tech.add_prerequisite("water-treatment-2", "fluid-handling")
bobmods.lib.tech.add_prerequisite("water-washing-2", "fluid-handling")

-- Nerf early game glass. Just need a little bit for arboretums
seablock.lib.substingredient("quartz-glass", "quartz", nil, 10)
seablock.lib.substresult("quartz-glass", "glass", nil, 1)

-- Biologically active tile has been hidden so no need for the prerequisites
bobmods.lib.tech.remove_prerequisite("bio-farm-2", "angels-glass-smelting-1")
bobmods.lib.tech.remove_prerequisite("bio-farm-2", "angels-stone-smelting-2")

-- Rebalance glass mixture recipes
bobmods.lib.recipe.remove_ingredient("glass-mixture-1", "quartz")
bobmods.lib.recipe.set_ingredient("glass-mixture-1", { "silicon-powder", 1 })

bobmods.lib.recipe.remove_ingredient("glass-mixture-2", "quartz")
bobmods.lib.recipe.set_ingredient("glass-mixture-2", { "silicon-powder", 2 })
bobmods.lib.recipe.set_result("glass-mixture-2", { "solid-glass-mixture", 3 })
bobmods.lib.recipe.set_energy_required("glass-mixture-2", 6)

bobmods.lib.recipe.remove_ingredient("glass-mixture-3", "quartz")
bobmods.lib.recipe.set_ingredient("glass-mixture-3", { "silicon-powder", 1 })
bobmods.lib.recipe.set_ingredient("glass-mixture-3", { "solid-lime", 2 })
bobmods.lib.recipe.set_result("glass-mixture-3", { "solid-glass-mixture", 4 })
bobmods.lib.recipe.set_energy_required("glass-mixture-3", 8)

bobmods.lib.recipe.set_energy_required("glass-mixture-4", 8)

-- Rebalance cement recipes
bobmods.lib.recipe.replace_ingredient("cement-mixture-1", "quartz", "silicon-powder")

bobmods.lib.recipe.remove_ingredient("cement-mixture-2", "iron-ore")
bobmods.lib.recipe.replace_ingredient("cement-mixture-2", "quartz", "silicon-powder")
bobmods.lib.recipe.set_ingredient("cement-mixture-2", { "solid-lime", 4 })
bobmods.lib.recipe.set_result("cement-mixture-2", { "solid-cement", 4 })
bobmods.lib.recipe.set_energy_required("cement-mixture-2", 16)
