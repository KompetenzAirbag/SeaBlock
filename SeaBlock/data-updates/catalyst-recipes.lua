-- Update catalyst recipes
bobmods.lib.tech.remove_recipe_unlock("basic-chemistry-3", "catalyst-metal-red")
seablock.lib.hide("item", "catalyst-metal-red")
bobmods.lib.recipe.hide("catalyst-metal-red")

bobmods.lib.recipe.set_ingredients("catalyst-metal-green", {
  { type = "item", name = "catalyst-metal-carrier", amount = 10 },
  { type = "item", name = "copper-ore", amount = 1 },
  { type = "item", name = "iron-ore", amount = 1 },
})
bobmods.lib.recipe.set_ingredients("catalyst-metal-blue", {
  { type = "item", name = "catalyst-metal-carrier", amount = 10 },
  { type = "item", name = "bob-bauxite-ore", amount = 1 },
  { type = "item", name = "bob-silver-ore", amount = 1 },
})
bobmods.lib.tech.add_recipe_unlock("angels-advanced-chemistry-4", "catalyst-metal-purple")

bobmods.lib.recipe.replace_ingredient("liquid-acetic-acid-catalyst", "catalyst-metal-red", "catalyst-metal-green")
bobmods.lib.recipe.replace_ingredient("gas-ammonia", "catalyst-metal-red", "catalyst-metal-green")
bobmods.lib.recipe.replace_ingredient("catalyst-steam-cracking-naphtha", "catalyst-metal-red", "catalyst-metal-green")

bobmods.lib.recipe.replace_ingredient("gas-synthesis-methanol", "catalyst-metal-green", "catalyst-metal-blue")
bobmods.lib.recipe.replace_ingredient("gas-acid-catalyst", "catalyst-metal-green", "catalyst-metal-blue")
bobmods.lib.recipe.replace_ingredient("liquid-styrene-catalyst", "catalyst-metal-green", "catalyst-metal-blue")
bobmods.lib.recipe.replace_ingredient("gas-benzene-catalyst", "catalyst-metal-green", "catalyst-metal-blue")
bobmods.lib.recipe.replace_ingredient("liquid-propionic-acid-catalyst", "catalyst-metal-green", "catalyst-metal-blue")
bobmods.lib.recipe.replace_ingredient("catalyst-steam-cracking-butane", "catalyst-metal-green", "catalyst-metal-blue")

bobmods.lib.recipe.replace_ingredient("liquid-naphtha-catalyst", "catalyst-metal-red", "catalyst-metal-purple")
bobmods.lib.recipe.replace_ingredient("solid-sodium-cyanide", "catalyst-metal-green", "catalyst-metal-purple")
bobmods.lib.recipe.replace_ingredient("gas-synthesis-methanation", "catalyst-metal-blue", "catalyst-metal-purple")
bobmods.lib.recipe.replace_ingredient("gas-hydrazine", "catalyst-metal-blue", "catalyst-metal-purple")
bobmods.lib.recipe.replace_ingredient("gas-synthesis-methanol", "catalyst-metal-blue", "catalyst-metal-purple")

bobmods.lib.recipe.replace_ingredient("cumene-process", "catalyst-metal-blue", "catalyst-metal-yellow")

bobmods.lib.recipe.add_new_ingredient(
  "liquid-mineral-oil-catalyst",
  { type = "item", name = "catalyst-metal-purple", amount = 1 }
)
bobmods.lib.recipe.add_result(
  "liquid-mineral-oil-catalyst",
  { type = "item", name = "catalyst-metal-carrier", amount = 1 }
)

bobmods.lib.tech.add_prerequisite("bio-plastic-2", "angels-advanced-chemistry-2")
bobmods.lib.tech.add_prerequisite("sodium-processing-2", "angels-advanced-chemistry-4")
bobmods.lib.tech.add_prerequisite("angels-advanced-chemistry-1", "basic-chemistry-3")
bobmods.lib.tech.add_prerequisite("angels-advanced-chemistry-3", "thermal-water-extraction-2")
bobmods.lib.tech.remove_prerequisite("angels-advanced-chemistry-1", "ore-floatation")

bobmods.lib.tech.add_new_science_pack("angels-nitrogen-processing-3", "production-science-pack", 1)
bobmods.lib.tech.add_prerequisite("angels-nitrogen-processing-3", "angels-advanced-chemistry-4")
bobmods.lib.tech.replace_prerequisite("resin-2", "angels-nitrogen-processing-3", "angels-advanced-chemistry-2")
seablock.lib.moveeffect("angels-air-filter-3", "angels-nitrogen-processing-3", "angels-advanced-chemistry-2", 4)
seablock.lib.moveeffect("gas-melamine", "angels-nitrogen-processing-3", "angels-advanced-chemistry-2")

bobmods.lib.tech.add_new_science_pack("gas-synthesis", "production-science-pack", 1)
bobmods.lib.tech.add_prerequisite("gas-synthesis", "angels-advanced-chemistry-4")

seablock.lib.moveeffect("liquid-mineral-oil-catalyst", "angels-advanced-chemistry-3", "angels-advanced-chemistry-4")
seablock.lib.moveeffect("catalyst-metal-carrier", "basic-chemistry-3", "angels-advanced-chemistry-1", 5)
seablock.lib.moveeffect("catalyst-metal-green", "angels-advanced-chemistry-1", "angels-advanced-chemistry-1", 6)
seablock.lib.moveeffect("catalyst-metal-blue", "angels-advanced-chemistry-3", "angels-advanced-chemistry-2", 8)
seablock.lib.moveeffect("catalyst-metal-yellow", "angels-advanced-chemistry-5", "angels-advanced-chemistry-5", 6)
