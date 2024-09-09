-- seablock.scripted_techs
-- Techs here are expected to be unlocked by the tutorial system
-- They will not have prerequisites added
seablock.scripted_techs = {
  ["sb-checkpoint-mud"] = {},
  ["automation"] = { "sb-checkpoint-mud" },
  ["landfill"] = { "sb-checkpoint-mud" },
  ["logistics-0"] = { "sb-checkpoint-mud" },
  ["sb-checkpoint-landfill"] = { "automation", "landfill", "logistics-0" },
  ["basic-chemistry"] = { "sb-checkpoint-landfill" },
  ["bio-processing-brown"] = { "sb-checkpoint-landfill" },
  ["bio-wood-processing"] = { "sb-checkpoint-landfill" },
  ["sb-checkpoint-charcoal"] = { "basic-chemistry", "bio-processing-brown", "bio-wood-processing" },
  ["steam-power"] = { "sb-checkpoint-charcoal" },
  ["water-treatment"] = { "steam-power" },
  ["angels-sulfur-processing-1"] = { "steam-power" },
  ["slag-processing-1"] = { "steam-power" },
  ["ore-crushing"] = { "steam-power" },
  ["sb-checkpoint-iron-plate"] = { "steam-power", "water-treatment", "angels-sulfur-processing-1", "slag-processing-1", "ore-crushing" },
  ["angels-composting"] = { "sb-checkpoint-iron-plate" },
  ["sb-checkpoint-soil"] = { "angels-composting" },
  ["bio-arboretum-1"] = { "sb-checkpoint-soil" },
  ["sb-checkpoint-wood"] = { "bio-arboretum-1" },
  ["bio-wood-processing-2"] = { "sb-checkpoint-wood" },
  ["sb-checkpoint-basic-circuit"] = { "bio-wood-processing-2" },
}

if data.raw.technology["sct-lab-t1"] then
  seablock.scripted_techs["sct-lab-t1"] = { "sb-checkpoint-basic-circuit" }
  seablock.scripted_techs["sb-checkpoint-lab"] = { "sct-lab-t1" }
else
  seablock.scripted_techs["sb-startup-lab"] = { "sb-checkpoint-basic-circuit" }
  seablock.scripted_techs["sb-checkpoint-lab"] = { "sb-startup-lab" }
end
if data.raw.technology["sct-automation-science-pack"] then
  seablock.scripted_techs["sct-automation-science-pack"] = { "sb-checkpoint-lab" }
end

seablock.checkpoint_techs = {
  ["sb-checkpoint-mud"] = true,
  ["sb-checkpoint-landfill"] = true,
  ["sb-checkpoint-charcoal"] = true,
  ["sb-checkpoint-iron-plate"] = true,
  ["sb-checkpoint-soil"] = true,
  ["sb-checkpoint-wood"] = true,
  ["sb-checkpoint-basic-circuit"] = true,
  ["sb-checkpoint-lab"] = true,
}

-- seablock.startup_techs
-- These techs will depend on the final startup tech
-- Their time will be standardized to 15 and they  will ignore tech cost modifier
-- If {true} then their cost will be set to 20 red science
-- Any other tech with no prerequisites will depend on Slag Processing 1
seablock.startup_techs = {
  ["angels-fluid-control"] = { true },
  -- Don't reduce the science pack cost of green algae
  ["bio-processing-green"] = { false },
  ["military"] = { true },
  ["optics"] = { true },
}

-- seablock.startup_recipes
-- These recipes will be available at the start of the game
seablock.startup_recipes = {
  ["clarifier"] = true,
  ["offshore-pump"] = true,
  ["seafloor-pump"] = true,
  ["washing-1"] = true,
  ["washing-2"] = true,
  ["washing-3"] = true,
  ["washing-4"] = true,
  ["washing-5"] = true,
  ["washing-plant"] = true,
}

-- seablock.final_scripted_tech
-- Startup techs will depend on this tech
if data.raw.technology["sct-automation-science-pack"] then
  seablock.final_scripted_tech = "sct-automation-science-pack"
else
  seablock.final_scripted_tech = "sb-startup-lab"
end

seablock.final_startup_tech = seablock.final_scripted_tech
