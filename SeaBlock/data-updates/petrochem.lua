-- Merge basic chemistry 2 into basic chemistry
local function movealleffects(from, to)
  for _, v in pairs(data.raw.technology[from].effects) do
    table.insert(data.raw.technology[to].effects, v)
  end
  for _, v in pairs(data.raw.technology) do
    for k, prerequisite in pairs(v.prerequisites or {}) do
      if prerequisite == from then
        v.prerequisites[k] = to
      end
    end
  end
  data.raw.technology[from].effects = {}
end
movealleffects("basic-chemistry-2", "basic-chemistry")
movealleffects("basic-chemistry-3", "basic-chemistry-2")
movealleffects("angels-advanced-chemistry-3", "angels-advanced-chemistry-2")
movealleffects("angels-advanced-chemistry-4", "angels-advanced-chemistry-3")
movealleffects("angels-advanced-chemistry-5", "angels-advanced-chemistry-4")
movealleffects("chlorine-processing-3", "chlorine-processing-2")
movealleffects("chlorine-processing-4", "chlorine-processing-2")
bobmods.lib.tech.add_new_science_pack("basic-chemistry-2", "logistic-science-pack", 1)
bobmods.lib.tech.add_new_science_pack("angels-advanced-chemistry-3", "production-science-pack", 1)
bobmods.lib.tech.add_new_science_pack("angels-advanced-chemistry-4", "utility-science-pack", 1)
bobmods.lib.tech.add_new_science_pack("chlorine-processing-2", "chemical-science-pack", 1)
bobmods.lib.tech.add_prerequisite("angels-advanced-chemistry-4", "angels-advanced-chemistry-3")
bobmods.lib.tech.add_prerequisite("angels-advanced-chemistry-4", "utility-science-pack")
bobmods.lib.tech.add_prerequisite("chlorine-processing-2", "sodium-processing-1")
bobmods.lib.tech.add_prerequisite("chlorine-processing-2", "angels-advanced-chemistry-2")
seablock.lib.hide_technology("basic-chemistry-3")
seablock.lib.hide_technology("angels-advanced-chemistry-5")
seablock.lib.hide_technology("chlorine-processing-3")
seablock.lib.hide_technology("chlorine-processing-4")

-- Move recipes back
seablock.lib.moveeffect("water-gas-shift-1", "basic-chemistry", "basic-chemistry-2")
seablock.lib.moveeffect("water-gas-shift-2", "basic-chemistry", "basic-chemistry-2")
bobmods.lib.tech.add_prerequisite("angels-nickel-smelting-1", "basic-chemistry-2")

-- Make Basic Chemistry depend on Wood Processing 2
bobmods.lib.tech.add_prerequisite("basic-chemistry", "bio-wood-processing-2")

-- Move Methane to Blue Science
bobmods.lib.tech.remove_recipe_unlock("angels-advanced-chemistry-2", "gas-refinery-small-2")
bobmods.lib.tech.remove_recipe_unlock("flammables", "solid-fuel-methane")
bobmods.lib.tech.remove_recipe_unlock("gas-processing", "gas-fractioning")
bobmods.lib.tech.remove_recipe_unlock("gas-processing", "gas-refining")
bobmods.lib.tech.remove_recipe_unlock("steam-cracking-1", "catalyst-steam-cracking-butane")
bobmods.lib.tech.remove_recipe_unlock("steam-cracking-1", "steam-cracking-butane")
bobmods.lib.tech.remove_recipe_unlock("steam-cracking-1", "steam-cracking-ethane")
bobmods.lib.tech.remove_recipe_unlock("steam-cracking-1", "steam-cracking-methane")
bobmods.lib.tech.remove_recipe_unlock("steam-cracking-2", "steam-cracking-oil-residual")

bobmods.lib.tech.add_recipe_unlock("angels-advanced-chemistry-2", "catalyst-steam-cracking-butane")
bobmods.lib.tech.add_recipe_unlock("angels-advanced-gas-processing", "gas-refinery-small-2")
bobmods.lib.tech.add_recipe_unlock("angels-advanced-gas-processing", "gas-refining")
bobmods.lib.tech.add_recipe_unlock("angels-advanced-gas-processing", "gas-fractioning")
bobmods.lib.tech.add_recipe_unlock("angels-advanced-gas-processing", "solid-fuel-methane")
bobmods.lib.tech.add_recipe_unlock("fluid-handling", "angels-storage-tank-1")
bobmods.lib.tech.add_recipe_unlock("steam-cracking-1", "steam-cracking-oil-residual")
bobmods.lib.tech.add_recipe_unlock("steam-cracking-2", "steam-cracking-butane")
bobmods.lib.tech.add_recipe_unlock("steam-cracking-2", "steam-cracking-ethane")
bobmods.lib.tech.add_recipe_unlock("steam-cracking-2", "steam-cracking-methane")
seablock.lib.add_recipe_unlock("bio-nutrient-paste", "gas-refinery-small", 2)

bobmods.lib.tech.remove_prerequisite("advanced-material-processing-2", "gas-processing")
bobmods.lib.tech.remove_prerequisite("angels-advanced-gas-processing", "steam-cracking-2")
bobmods.lib.tech.remove_prerequisite("angels-oil-processing", "oil-gas-extraction")
bobmods.lib.tech.remove_prerequisite("angels-sulfur-processing-3", "gas-processing")
bobmods.lib.tech.remove_prerequisite("bio-nutrient-paste", "gas-processing")
bobmods.lib.tech.remove_prerequisite("bio-processing-paste", "chlorine-processing-2")
bobmods.lib.tech.remove_prerequisite("gas-processing", "oil-gas-extraction")
bobmods.lib.tech.remove_prerequisite("steam-cracking-1", "gas-processing")
bobmods.lib.tech.remove_prerequisite("steam-cracking-2", "angels-advanced-chemistry-2")

bobmods.lib.tech.add_prerequisite("angels-advanced-chemistry-2", "steam-cracking-2")
bobmods.lib.tech.add_prerequisite("angels-advanced-gas-processing", "bio-nutrient-paste")
bobmods.lib.tech.add_prerequisite("angels-advanced-gas-processing", "bio-refugium-puffer-1")
bobmods.lib.tech.add_prerequisite("angels-oil-processing", "fluid-handling")
bobmods.lib.tech.add_prerequisite("bio-processing-paste", "chlorine-processing-1")
bobmods.lib.tech.add_prerequisite("steam-cracking-2", "angels-advanced-gas-processing")

bobmods.lib.tech.hide("gas-processing")
bobmods.lib.tech.hide("oil-gas-extraction")
