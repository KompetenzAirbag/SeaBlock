-- Revert massive buff of insulated wire recipe
bobmods.lib.recipe.set_energy_required("bob-insulated-cable", 2)
seablock.lib.substingredient("bob-insulated-cable", "bob-tinned-copper-cable", nil, 8)
seablock.lib.substingredient("bob-insulated-cable", "bob-rubber", nil, 8)
bobmods.lib.recipe.set_result("bob-insulated-cable", { type = "item", name = "bob-insulated-cable", amount = 8 })

-- Combine Stone and Crushed Stone
local function replace_stone(recipe)
  if recipe.ingredients then
    for _, ingredient in pairs(recipe.ingredients) do
      if ingredient.name == "stone" then
        ingredient.amount = ingredient.amount * 2
      elseif ingredient.name == "angels-stone-crushed" then
        ingredient.name = "stone"
      elseif ingredient[1] == "stone" then
        ingredient[2] = ingredient[2] * 2
      elseif ingredient[1] == "angels-stone-crushed" then
        ingredient[1] = "stone"
      end
    end
  end
  if recipe.results then --needed for recipes parameter- which have no results
    for _, result in pairs(recipe.results) do
      if result.name == "stone" then
        result.amount = result.amount * 2
      elseif result.name == "angels-stone-crushed" then
        result.name = "stone"
      elseif result[1] == "stone" then
        result[2] = result[2] * 2
      elseif result[1] == "angels-stone-crushed" then
        result[1] = "stone"
      end
    end
  end
  if recipe.main_product == "angels-stone-crushed" then
    recipe.main_product = "stone"
  end
end
for _, recipe in pairs(data.raw.recipe) do
  replace_stone(recipe)
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

-- Recipe gets changed by bobwarfare to include coal which is unobtainable
bobmods.lib.recipe.set_ingredients("firearm-magazine", {{ type = "item", name = "iron-plate", amount = 4}}) --this function automatically clears previous ingredients