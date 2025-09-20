-- Adjust rubber production amount to how it was in petrochem 0.7.9.
-- TODO: Revisit this after Angel adds more liquid rubber recipes
seablock.lib.substresult("angels-liquid-rubber", "angels-liquid-rubber", nil, 20)

-- Reduce burner heat source neighbour bonus
local reactors = {
  "burner-reactor",
  "burner-reactor-2",
  "fluid-reactor",
  "fluid-reactor-2",
}

for _, v in pairs(reactors) do
  local r = data.raw.reactor[v]
  if r then
    r.neighbour_bonus = 0.125
  end
end

-- Refresh circuit board icon as it may have been overwritten
-- if data.raw.tool["sb-basic-circuit-board-tool"] and data.raw.item["bob-basic-circuit-board"] then
--   seablock.lib.copy_icon(data.raw.tool["sb-basic-circuit-board-tool"], data.raw.item["bob-basic-circuit-board"])
-- end

require("data-final-fixes/logistics")
require("data-final-fixes/icons")
require("data-final-fixes/recipe")
require("data-final-fixes/tech-tree")
require("data-final-fixes/unobtainable_items")
require("data-final-fixes/mapgen")
require("data-final-fixes/SpaceMod")
require("data-final-fixes/entities")


data.raw.recipe["copper-cable"].allow_decomposition = true
data.raw.recipe["angels-solid-paper"].allow_decomposition = true

for _, v in pairs(data.raw.character) do
  v.crafting_categories = v.crafting_categories or {}
  
  table.insert(v.crafting_categories, "sb-crafting-handonly")
  table.insert(v.crafting_categories, "sb-hand-electronics")
end

local function add_recipe_category(recipe_name, category_name)
  local recipe = data.raw.recipe[recipe_name]
  if (not recipe) then error("Tried to set recipe category for recipe "..recipe_name..": Recipe not found") end

  recipe.additional_categories = recipe.additional_categories or {}

  table.insert(recipe.additional_categories, category_name)
end

-- Adds handcrafting recipes because crafting category "electronics" is no longer craftable by hand
local handcrafting_recipes = {
  "electronic-circuit",
  "copper-cable",
  "advanced-circuit",
  "bob-tinned-copper-cable",
  "bob-insulated-cable",
  "bob-gilded-copper-cable",
  "bob-wooden-board",
  "bob-basic-circuit-board",
  "bob-robot-brain",
  "bob-robot-brain-2",
  "bob-robot-brain-3",
  "bob-robot-brain-4",
  "bob-module-case",
  "bob-module-contact",
  "bob-speed-processor",
  "bob-efficiency-processor",
  "bob-productivity-processor",
  "angels-wire-gold",
  "angels-wire-platinum",
  "angels-wire-silver",
  "angels-wire-tin",
  "cp-electronic-circuit-board",
  "cp-advanced-circuit-board"
}

for _, name in pairs(handcrafting_recipes) do
  add_recipe_category(name, "crafting")
end