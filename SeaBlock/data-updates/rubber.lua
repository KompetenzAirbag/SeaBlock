bobmods.lib.recipe.hide("bob-rubber")
bobmods.lib.tech.add_recipe_unlock("angels-rubbers", "bob-insulated-cable")

if mods["CircuitProcessing"] then
  bobmods.lib.tech.add_prerequisite("efficiency-module", "angels-rubbers")
  bobmods.lib.tech.add_prerequisite("productivity-module", "angels-rubbers")
  bobmods.lib.tech.add_prerequisite("speed-module", "angels-rubbers")
end
