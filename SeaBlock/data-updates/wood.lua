-- Remove wood from basic underground belt and splitter recipes
seablock.lib.removeingredient("bob-basic-underground-belt", "wood")
seablock.lib.removeingredient("bob-basic-splitter", "wood")

-- Can always apply productivity modules to furnace recipes, so make it official
-- for k, v in pairs(data.raw.module) do
--   if v.effect and v.effect.productivity and v.limitation then
--     table.insert(v.limitation, "sb-wood-bricks-charcoal")
--   end
-- end
angelsmods.functions.allow_productivity("sb-wood-bricks-charcoal")

bobmods.lib.recipe.enabled("wooden-chest", false)
bobmods.lib.recipe.enabled("bob-wooden-board", false)
bobmods.lib.recipe.enabled("cellulose-fiber-raw-wood", false)

bobmods.lib.tech.remove_recipe_unlock("bio-wood-processing", "wood-pellets")
bobmods.lib.tech.add_recipe_unlock("bio-wood-processing", "small-electric-pole")
bobmods.lib.tech.add_recipe_unlock("bio-wood-processing", "wooden-chest")
bobmods.lib.tech.add_recipe_unlock("bio-wood-processing", "bob-wooden-board")
bobmods.lib.tech.add_recipe_unlock("bio-wood-processing", "bob-basic-circuit-board")

bobmods.lib.tech.remove_prerequisite("bio-wood-processing-2", "bio-farm-1")
bobmods.lib.tech.remove_prerequisite("bio-wood-processing-2", "bio-wood-processing")
bobmods.lib.tech.add_prerequisite("bio-wood-processing-2", "bio-processing-brown")
bobmods.lib.tech.remove_recipe_unlock("bio-wood-processing-2", "wood-charcoal")
bobmods.lib.tech.remove_recipe_unlock("bio-wood-processing-2", "bio-resin-wood-reprocessing")
bobmods.lib.tech.remove_recipe_unlock("bio-wood-processing-2", "bob-rubber") -- TODO : check if this is supposed to be bob-rubber
bobmods.lib.tech.remove_recipe_unlock("bio-wood-processing-2", "bio-processor")
bobmods.lib.tech.add_recipe_unlock("bio-wood-processing-2", "wood-pellets")
bobmods.lib.tech.add_recipe_unlock("bio-wood-processing-2", "wood-bricks")
bobmods.lib.tech.add_recipe_unlock("bio-wood-processing-2", "sb-wood-bricks-charcoal")
bobmods.lib.tech.add_recipe_unlock("bio-wood-processing-2", "carbon-separation-2")

bobmods.lib.tech.remove_prerequisite("bio-wood-processing-3", "angels-coal-processing")
bobmods.lib.tech.add_prerequisite("bio-wood-processing-3", "bio-arboretum-1")
bobmods.lib.tech.remove_recipe_unlock("bio-wood-processing-3", "wood-bricks")
bobmods.lib.tech.add_recipe_unlock("bio-wood-processing-3", "cellulose-fiber-raw-wood")

-- Remove solid resin
bobmods.lib.recipe.hide("bio-resin-wood-reprocessing")
bobmods.lib.tech.remove_prerequisite("bio-wood-processing-2", "bio-farm-1")
bobmods.lib.tech.remove_recipe_unlock("resins", "solid-resin")
bobmods.lib.recipe.hide("solid-resin")
seablock.lib.hide_item("resin")
bobmods.lib.tech.remove_recipe_unlock("bio-arboretum-temperate-1", "bio-resin-resin-liquification")
bobmods.lib.recipe.hide("bio-resin-resin-liquification")
