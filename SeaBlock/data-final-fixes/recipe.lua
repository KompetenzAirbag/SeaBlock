-- Revert massive buff of insulated wire recipe
bobmods.lib.recipe.set_energy_required("bob-insulated-cable", 2)
seablock.lib.substingredient("bob-insulated-cable", "bob-tinned-copper-cable", nil, 8)
seablock.lib.substingredient("bob-insulated-cable", "bob-rubber", nil, 8)
bobmods.lib.recipe.set_result("bob-insulated-cable", { type = "item", name = "bob-insulated-cable", amount = 8 })

-- Combine Stone and Crushed Stone
for _, recipe in pairs(data.raw.recipe) do
  if recipe.ingredients then
    for _, ingredient in pairs(recipe.ingredients) do
      if ingredient.name == "stone" then
        ingredient.amount = ingredient.amount * 2
      elseif ingredient.name == "angels-stone-crushed" then
        ingredient.name = "stone"
      end
    end
  end
  if recipe.results then --needed for recipes parameter- which have no results
    for _, result in pairs(recipe.results) do
      if result.name == "stone" then
        result.amount = result.amount * 2
      elseif result.name == "angels-stone-crushed" then
        result.name = "stone"
      end
    end
  end
  if recipe.main_product == "angels-stone-crushed" then
    recipe.main_product = "stone"
  end
end
bobmods.lib.recipe.hide("angels-stone-from-crushed-stone")
seablock.lib.hide("item", "angels-stone-crushed")

if data.raw.recipe["angels-stone-crushed-dissolution"] then
  data.raw.recipe["angels-stone-crushed-dissolution"].icons = angelsmods.functions.create_liquid_recipe_icon(
    nil,
    { { 142, 079, 028 }, { 107, 062, 021 }, { 075, 040, 015 } },
    { "stone" }
  )
end
