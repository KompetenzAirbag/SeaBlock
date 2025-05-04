seablock.lib.hide("mining-drill", "burner-mining-drill")
seablock.lib.hide("mining-drill", "electric-mining-drill")
seablock.lib.hide("mining-drill", "pumpjack")
seablock.lib.hide("storage-tank", "overflow-valve")
seablock.lib.hide("storage-tank", "valve")
seablock.lib.hide("storage-tank", "topup-valve")

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
bobmods.lib.recipe.hide("gas-chlor-methane-barrel")
bobmods.lib.recipe.hide("liquid-multi-phase-oil-barrel")
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
bobmods.lib.tech.remove_recipe_unlock("bob-fluid-barrel-processing", "empty-liquid-multi-phase-oil-barrel")
bobmods.lib.tech.remove_recipe_unlock("bob-fluid-barrel-processing", "liquid-multi-phase-oil-barrel")
bobmods.lib.tech.remove_recipe_unlock("bob-gas-canisters", "empty-gas-chlor-methane-barrel")
bobmods.lib.tech.remove_recipe_unlock("bob-gas-canisters", "fill-gas-chlor-methane-barrel")
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
seablock.lib.hide("inserter", "bob-steam-inserter")
bobmods.lib.recipe.hide("bob-steam-inserter")
seablock.lib.hide_item("bob-steam-inserter")
if data.raw.inserter["bob-steam-inserter"] then
  data.raw.inserter["bob-steam-inserter"].next_upgrade = nil
  bobmods.lib.recipe.replace_ingredient_in_all("bob-steam-inserter", "burner-inserter")
end
bobmods.lib.tech.remove_recipe_unlock(seablock.final_scripted_tech, "bob-steam-inserter")

-- Hide Liquid Fuel
if data.raw.recipe["bob-enriched-fuel"] then
  bobmods.lib.recipe.set_ingredients("bob-enriched-fuel", {
    { type = "fluid", name = "liquid-fuel-oil", amount = 80 },
    { type = "fluid", name = "gas-residual", amount = 20 },
  })
  data.raw.recipe["bob-enriched-fuel"].icons =
    angelsmods.functions.create_solid_recipe_icon({ "liquid-fuel-oil", "gas-residual" }, "bob-enriched-fuel")
end
bobmods.lib.tech.remove_recipe_unlock("bob-fluid-canister-processing", "empty-bob-liquid-fuel-barrel")
bobmods.lib.tech.remove_recipe_unlock("bob-fluid-canister-processing", "bob-liquid-fuel-barrel")
bobmods.lib.tech.remove_recipe_unlock("flammables", "bob-liquid-fuel")
bobmods.lib.recipe.hide("empty-bob-liquid-fuel-barrel")
bobmods.lib.recipe.hide("bob-liquid-fuel-barrel")
bobmods.lib.recipe.hide("bob-liquid-fuel")
seablock.lib.hide("fluid", "bob-liquid-fuel")
seablock.lib.hide("item", "bob-liquid-fuel-barrel")

-- Swap out Nickel and Zinc plates
seablock.lib.substingredient("bob-roboport-antenna-3", "bob-nickel-plate", "bob-titanium-plate", nil)
bobmods.lib.recipe.remove_ingredient("bob-roboport-antenna-4", "bob-nickel-plate")
seablock.lib.substingredient("bob-silver-zinc-battery", "bob-zinc-plate", "solid-zinc-oxide", nil)

seablock.lib.unhide_recipe("zinc-ore-processing-alt")
bobmods.lib.tech.add_recipe_unlock("angels-zinc-smelting-2", "zinc-ore-processing-alt")
bobmods.lib.tech.add_prerequisite("bob-battery-3", "angels-zinc-smelting-2")
if data.raw.recipe["pellet-zinc-smelting"] then
  data.raw.recipe["pellet-zinc-smelting"].icons = angelsmods.functions.add_number_icon_layer(
    angelsmods.functions.get_object_icons("solid-zinc-oxide"),
    2,
    angelsmods.smelting.number_tint
  )
end

if mods["angelsindustries"] then
  seablock.lib.substingredient("angels-thorium-fuel-cell", "angels-plate-zinc", "bob-lead-plate", nil)
  seablock.lib.substingredient("angels-deuterium-fuel-cell", "angels-plate-zinc", "bob-lead-plate", nil)
end

seablock.lib.hide_item("bob-nickel-plate")
seablock.lib.hide_item("bob-zinc-plate")
bobmods.lib.recipe.hide("bob-zinc-plate")
bobmods.lib.tech.remove_recipe_unlock("bob-zinc-processing", "bob-zinc-plate")

if mods["cargo-ships"] then
  seablock.lib.hide_item("oil_rig")
end

-- Hide the farm environment kits
seablock.lib.hide("item", "desert-upgrade")
seablock.lib.hide("item", "swamp-upgrade")
seablock.lib.hide("item", "temperate-upgrade")
bobmods.lib.tech.remove_recipe_unlock("bio-desert-farm", "desert-upgrade")
bobmods.lib.tech.remove_recipe_unlock("bio-swamp-farm", "swamp-upgrade")
bobmods.lib.tech.remove_recipe_unlock("bio-temperate-farm", "temperate-upgrade")
bobmods.lib.recipe.hide("desert-upgrade")
bobmods.lib.recipe.hide("swamp-upgrade")
bobmods.lib.recipe.hide("temperate-upgrade")

bobmods.lib.recipe.remove_ingredient("desert-farm", "desert-upgrade")
bobmods.lib.recipe.add_ingredient("desert-farm", { type = "item", name = "token-bio", amount = 5 })
bobmods.lib.recipe.remove_ingredient("swamp-farm", "swamp-upgrade")
bobmods.lib.recipe.add_ingredient("swamp-farm", { type = "item", name = "token-bio", amount = 5 })
bobmods.lib.recipe.remove_ingredient("temperate-farm", "temperate-upgrade")
bobmods.lib.recipe.add_ingredient("temperate-farm", { type = "item", name = "token-bio", amount = 5 })
