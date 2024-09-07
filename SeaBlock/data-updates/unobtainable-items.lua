seablock.lib.hide("mining-drill", "burner-mining-drill")
seablock.lib.hide("mining-drill", "electric-mining-drill")
seablock.lib.hide("mining-drill", "pumpjack")
seablock.lib.hide("storage-tank", "bob-overflow-valve")
seablock.lib.hide("storage-tank", "bob-valve")
seablock.lib.hide("storage-tank", "bob-topup-valve")

-- Hide Oil & Gas Separator
-- Hide Advanced Gas Refinery
-- Hide Electrowinning Cell
-- Hide Chlormethane Gas
-- Hide Multi-phase oil
-- Hide gas fractioning - synthesis (only recipe available in advanced gas refinery)
for _, item in pairs({
  { type = "assembling-machine", name = "electro-whinning-cell" },
  { type = "assembling-machine", name = "electro-whinning-cell-2" },
  { type = "assembling-machine", name = "gas-refinery" },
  { type = "assembling-machine", name = "gas-refinery-2" },
  { type = "assembling-machine", name = "gas-refinery-3" },
  { type = "assembling-machine", name = "gas-refinery-4" },
  { type = "assembling-machine", name = "separator" },
  { type = "assembling-machine", name = "separator-2" },
  { type = "assembling-machine", name = "separator-3" },
  { type = "assembling-machine", name = "separator-4" },
  { type = "fluid", name = "gas-chlor-methane" },
  { type = "fluid", name = "liquid-multi-phase-oil" },
  { type = "item", name = "electro-whinning-cell" },
  { type = "item", name = "electro-whinning-cell-2" },
  { type = "item", name = "gas-chlor-methane-barrel" },
  { type = "item", name = "gas-refinery" },
  { type = "item", name = "gas-refinery-2" },
  { type = "item", name = "gas-refinery-3" },
  { type = "item", name = "gas-refinery-4" },
  { type = "item", name = "liquid-multi-phase-oil-barrel" },
  { type = "item", name = "separator" },
  { type = "item", name = "separator-2" },
  { type = "item", name = "separator-3" },
  { type = "item", name = "separator-4" },
}) do
  seablock.lib.hide(item.type, item.name)
end

bobmods.lib.recipe.hide("angels-chemical-void-gas-chlor-methane")
bobmods.lib.recipe.hide("angels-chemical-void-liquid-multi-phase-oil")
bobmods.lib.recipe.hide("electro-whinning-cell")
bobmods.lib.recipe.hide("electro-whinning-cell-2")
bobmods.lib.recipe.hide("empty-gas-chlor-methane-barrel")
bobmods.lib.recipe.hide("empty-liquid-multi-phase-oil-barrel")
bobmods.lib.recipe.hide("fill-gas-chlor-methane-barrel")
bobmods.lib.recipe.hide("fill-liquid-multi-phase-oil-barrel")
bobmods.lib.recipe.hide("gas-chlor-methane")
bobmods.lib.recipe.hide("gas-fractioning-synthesis")
bobmods.lib.recipe.hide("gas-refinery")
bobmods.lib.recipe.hide("gas-refinery-2")
bobmods.lib.recipe.hide("gas-refinery-3")
bobmods.lib.recipe.hide("gas-refinery-4")
bobmods.lib.recipe.hide("oil-separation")
bobmods.lib.recipe.hide("separator")
bobmods.lib.recipe.hide("separator-2")
bobmods.lib.recipe.hide("separator-3")
bobmods.lib.recipe.hide("separator-4")

bobmods.lib.tech.remove_recipe_unlock("advanced-ore-refining-4", "electro-whinning-cell-2")
bobmods.lib.tech.remove_recipe_unlock("angels-advanced-chemistry-2", "separator-2")
bobmods.lib.tech.remove_recipe_unlock("angels-advanced-chemistry-3", "gas-refinery-2")
bobmods.lib.tech.remove_recipe_unlock("angels-advanced-chemistry-3", "separator-3")
bobmods.lib.tech.remove_recipe_unlock("angels-advanced-chemistry-4", "gas-refinery-3")
bobmods.lib.tech.remove_recipe_unlock("angels-advanced-chemistry-4", "separator-4")
bobmods.lib.tech.remove_recipe_unlock("angels-advanced-gas-processing", "gas-fractioning-synthesis")
bobmods.lib.tech.remove_recipe_unlock("angels-advanced-gas-processing", "gas-refinery")
bobmods.lib.tech.remove_recipe_unlock("angels-nitrogen-processing-4", "gas-refinery-4")
bobmods.lib.tech.remove_recipe_unlock("chlorine-processing-2", "gas-chlor-methane")
bobmods.lib.tech.remove_recipe_unlock("fluid-barrel-processing", "empty-liquid-multi-phase-oil-barrel")
bobmods.lib.tech.remove_recipe_unlock("fluid-barrel-processing", "fill-liquid-multi-phase-oil-barrel")
bobmods.lib.tech.remove_recipe_unlock("gas-canisters", "empty-gas-chlor-methane-barrel")
bobmods.lib.tech.remove_recipe_unlock("gas-canisters", "fill-gas-chlor-methane-barrel")
bobmods.lib.tech.remove_recipe_unlock("ore-electro-whinning-cell", "electro-whinning-cell")

bobmods.lib.recipe.replace_ingredient("paste-cellulose", "gas-chlor-methane", "gas-chlorine")

-- Hide recipes that take Chrome Ingots
bobmods.lib.recipe.hide("molten-iron-smelting-5")
bobmods.lib.tech.hide("angels-iron-casting-4")

bobmods.lib.recipe.hide("molten-steel-smelting-5")
bobmods.lib.tech.hide("angels-steel-smelting-4")

bobmods.lib.recipe.hide("molten-titanium-smelting-5")
bobmods.lib.tech.remove_recipe_unlock("angels-titanium-casting-3", "molten-titanium-smelting-5")
bobmods.lib.tech.remove_prerequisite("angels-titanium-casting-3", "angels-chrome-smelting-1")

-- Hide steam inserter
seablock.lib.hide("inserter", "steam-inserter")
bobmods.lib.recipe.hide("steam-inserter")
seablock.lib.hide_item("steam-inserter")
if data.raw.inserter["steam-inserter"] then
  data.raw.inserter["steam-inserter"].next_upgrade = nil
  bobmods.lib.recipe.replace_ingredient_in_all("steam-inserter", "burner-inserter")
end
bobmods.lib.tech.remove_recipe_unlock(seablock.final_scripted_tech, "steam-inserter")

-- Hide Liquid Fuel
if data.raw.recipe["enriched-fuel-from-liquid-fuel"] then
  bobmods.lib.recipe.set_ingredients("enriched-fuel-from-liquid-fuel", {
    { type = "fluid", name = "liquid-fuel-oil", amount = 80 },
    { type = "fluid", name = "gas-residual", amount = 20 },
  })
  data.raw.recipe["enriched-fuel-from-liquid-fuel"].icons =
    angelsmods.functions.create_solid_recipe_icon({ "liquid-fuel-oil", "gas-residual" }, "enriched-fuel")
end
bobmods.lib.tech.remove_recipe_unlock("fluid-canister-processing", "empty-liquid-fuel-barrel")
bobmods.lib.tech.remove_recipe_unlock("fluid-canister-processing", "fill-liquid-fuel-barrel")
bobmods.lib.tech.remove_recipe_unlock("flammables", "liquid-fuel")
bobmods.lib.recipe.hide("empty-liquid-fuel-barrel")
bobmods.lib.recipe.hide("fill-liquid-fuel-barrel")
bobmods.lib.recipe.hide("liquid-fuel")
seablock.lib.hide("fluid", "liquid-fuel")
seablock.lib.hide("item", "liquid-fuel-barrel")

-- Swap out Nickel and Zinc plates
seablock.lib.substingredient("roboport-antenna-3", "nickel-plate", "titanium-plate", nil)
bobmods.lib.recipe.remove_ingredient("roboport-antenna-4", "nickel-plate")
seablock.lib.substingredient("silver-zinc-battery", "zinc-plate", "solid-zinc-oxide", nil)

seablock.lib.unhide_recipe("zinc-ore-processing-alt")
bobmods.lib.tech.add_recipe_unlock("angels-zinc-smelting-2", "zinc-ore-processing-alt")
bobmods.lib.tech.add_prerequisite("battery-3", "angels-zinc-smelting-2")
if data.raw.recipe["pellet-zinc-smelting"] then
  data.raw.recipe["pellet-zinc-smelting"].icons = angelsmods.functions.add_number_icon_layer(
    angelsmods.functions.get_object_icons("solid-zinc-oxide"),
    2,
    angelsmods.smelting.number_tint
  )
end

if mods["angelsindustries"] then
  seablock.lib.substingredient("angels-thorium-fuel-cell", "angels-plate-zinc", "lead-plate", nil)
  seablock.lib.substingredient("angels-deuterium-fuel-cell", "angels-plate-zinc", "lead-plate", nil)
end

seablock.lib.hide_item("nickel-plate")
seablock.lib.hide_item("zinc-plate")
bobmods.lib.recipe.hide("bob-zinc-plate")
bobmods.lib.tech.remove_recipe_unlock("zinc-processing", "bob-zinc-plate")

if mods["cargo-ships"] then
  seablock.lib.hide_item("oil_rig")
end
