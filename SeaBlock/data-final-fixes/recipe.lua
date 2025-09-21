-- Revert massive buff of insulated wire recipe
bobmods.lib.recipe.set_energy_required("insulated-cable", 2)
seablock.lib.substingredient("insulated-cable", "tinned-copper-cable", nil, 8)
seablock.lib.substingredient("insulated-cable", "rubber", nil, 8)
bobmods.lib.recipe.set_result("insulated-cable", { "insulated-cable", 8 })

if (mods["blueprint-shotgun"]) then
  seablock.lib.unhide_recipe("shotgun")
  seablock.lib.unhide_recipe("shotgun-shell")

  seablock.lib.unhide("gun", "shotgun")
  seablock.lib.unhide("ammo", "shotgun-shell")

  bobmods.lib.tech.add_recipe_unlock("military", "shotgun")
  bobmods.lib.tech.add_recipe_unlock("military", "shotgun-shell")
end
