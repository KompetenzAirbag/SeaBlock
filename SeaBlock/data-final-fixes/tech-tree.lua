-- Remove empty bob's techs
bobmods.lib.tech.remove_prerequisite("bob-cobalt-processing", "bob-chemical-processing-1")
bobmods.lib.tech.remove_prerequisite("bob-grinding", "bob-chemical-processing-1")
bobmods.lib.tech.remove_prerequisite("bob-lithium-processing", "bob-chemical-processing-1")

bobmods.lib.tech.remove_prerequisite("bob-cobalt-processing", "bob-chemical-processing-2")
bobmods.lib.tech.remove_prerequisite("bob-silicon-processing", "bob-chemical-processing-2")
bobmods.lib.tech.remove_prerequisite("advanced-circuit", "bob-chemical-processing-2")
bobmods.lib.tech.remove_prerequisite("bob-titanium-processing", "bob-chemical-processing-2")
bobmods.lib.tech.remove_prerequisite("bob-tungsten-processing", "bob-chemical-processing-2")

seablock.lib.hide_technology("bob-electrolysis-1")
seablock.lib.hide_technology("bob-electrolysis-2")
seablock.lib.hide_technology("bob-chemical-processing-1")
seablock.lib.hide_technology("bob-chemical-processing-2")

bobmods.lib.tech.remove_prerequisite("circuit-network", "angels-bio-wood-processing-2")
bobmods.lib.tech.add_prerequisite("circuit-network", "angels-bio-paper-1")
bobmods.lib.tech.remove_prerequisite("angels-rubbers", "circuit-network")

-- alien research is disabled with SeaBlock
bobmods.lib.tech.remove_prerequisite("bob-exoskeleton-equipment-3", "bob-alien-blue-research")

bobmods.lib.tech.remove_prerequisite("bob-fission-reactor-equipment-3", "bob-alien-research")
bobmods.lib.tech.remove_prerequisite("bob-fission-reactor-equipment-4", "bob-alien-blue-research")
bobmods.lib.tech.remove_prerequisite("bob-fission-reactor-equipment-4", "bob-alien-red-research")

bobmods.lib.tech.remove_prerequisite("bob-personal-laser-defense-equipment-6", "bob-alien-orange-research")
bobmods.lib.tech.remove_prerequisite("bob-personal-laser-defense-equipment-6", "bob-alien-blue-research")
bobmods.lib.tech.remove_prerequisite("bob-personal-laser-defense-equipment-6", "bob-alien-green-research")

bobmods.lib.tech.remove_prerequisite("bob-power-armor-3", "bob-alien-research")

-- Unhide solid fuel from hydrogen
seablock.lib.unhide_recipe("bob-solid-fuel-from-hydrogen")
seablock.lib.add_recipe_unlock("flammables", "bob-solid-fuel-from-hydrogen", 4)
data.raw.recipe["bob-solid-fuel-from-hydrogen"].localised_name = nil

bobmods.lib.tech.replace_prerequisite("bob-lithium-processing", "angels-chlorine-processing-4", "angels-chlorine-processing-2")

-- electronics is hidden since it is a trigger tech and is replaced by bob-electronics
bobmods.lib.tech.remove_prerequisite("automation-2", "electronics")
bobmods.lib.tech.remove_prerequisite("logistics-2", "electronics")
bobmods.lib.tech.remove_prerequisite("bob-chemical-plant", "electronics")

-- repair-pack is now unlocked with military
bobmods.lib.tech.remove_prerequisite("bob-repair-pack-2", "repair-pack")

bobmods.lib.tech.remove_prerequisite("lubricant", "bob-chemical-plant")
bobmods.lib.tech.remove_prerequisite("plastics", "bob-chemical-plant")

bobmods.lib.tech.hide("bob-chemical-plant")

-- uranium mining only adds fluid inputs to mining drills which is never used
bobmods.lib.tech.hide("uranium-mining")
bobmods.lib.tech.remove_prerequisite("uranium-processing", "uranium-mining")

-- needed for bio-module to be researchable
bobmods.lib.tech.remove_prerequisite("angels-bio-yield-module", "bob-pollution-create-module-1")
bobmods.lib.tech.remove_prerequisite("angels-bio-yield-module-2", "bob-pollution-create-module-2")
bobmods.lib.tech.remove_prerequisite("angels-bio-yield-module-3", "bob-pollution-create-module-3")
bobmods.lib.tech.remove_prerequisite("angels-bio-yield-module-4", "bob-pollution-create-module-4")
bobmods.lib.tech.remove_prerequisite("angels-bio-yield-module-5", "bob-pollution-create-module-5")