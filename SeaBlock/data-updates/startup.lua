-- First stage:   circuit board  pipe  pipe-to-ground  iron-gear  iron-stick  copper-pipe
-- Electrolyser   5                                               22*4
-- Liquifier      5                    2
-- Flare stack    5*2            10*2
-- Offshore pump  2              1                     10
-- Crystallizer   5                                                           5

-- luacheck: globals table.deepcopy

local knowningredients = {
  ["angels-electrolyser"] = {
    { "iron-plate", 10 },
    { "bob-basic-circuit-board", 5 },
    { "iron-stick", 22 },
    { "stone-brick", 10 },
  },
  ["angels-liquifier"] = {
    { "iron-plate", 10 },
    { "bob-basic-circuit-board", 5 },
    { "pipe-to-ground", 2 },
    { "stone-brick", 10 },
  },
  ["offshore-pump"] = {
    { "bob-basic-circuit-board", 2 },
    { "pipe", 1 },
    { "iron-gear-wheel", 10 },
  },
  ["angels-crystallizer"] = {
    { "iron-plate", 10 },
    { "bob-basic-circuit-board", 5 },
    { "bob-copper-pipe", 5 },
    { "stone-brick", 10 },
  },
  ["angels-algae-farm"] = {
    { "iron-plate", 10 },
    { "bob-basic-circuit-board", 5 },
    { "iron-stick", 10 },
    { "stone-brick", 25 },
  },
  ["angels-flare-stack"] = {
    { "iron-plate", 5 },
    { "bob-basic-circuit-board", 5 },
    { "pipe", 10 },
    { "stone-brick", 10 },
  },
  ["angels-seafloor-pump"] = {
    { "iron-plate", 5 },
    { "bob-basic-circuit-board", 2 },
    { "pipe", 5 },
  },
  ["angels-washing-plant"] = {
    { "iron-plate", 10 },
    { "bob-basic-circuit-board", 5 },
    { "pipe", 10 },
    { "stone-brick", 10 },
  },
  ["chemical-plant"] = {
    { "iron-plate", 5 },
    { "iron-gear-wheel", 5 },
    { "bob-basic-circuit-board", 5 },
    { "pipe", 5 },
  },
  ["angels-filtration-unit"] = {
    { "iron-plate", 5 },
    { "bob-basic-circuit-board", 5 },
    { "pipe", 10 },
    { "stone-brick", 10 },
  },
  ["angels-filter-frame"] = {
    { "iron-plate", 1 },
    { "iron-stick", 2 },
  },
  ["angels-burner-ore-crusher"] = {
    { "stone", 5 },
    { "stone-furnace", 1 },
  },
}

bobmods.lib.recipe.enabled("angels-flare-stack", true)
seablock.lib.hide_technology("angels-flare-stack")
for k, v in pairs(knowningredients) do
  local recipe = data.raw.recipe[k]
  recipe.ingredients = {}
  for _, line in pairs(v) do
    table.insert(recipe.ingredients, { type = "item", name = line[1], amount = line[2] })
  end
end

-- unlock lab and optional components with Basic Circuit Board
local sct_lab_tech = data.raw.technology["sct-lab-t1"]
if sct_lab_tech then
  bobmods.lib.tech.add_prerequisite("sct-lab-t1", "sb-startup3")
else
  -- Without Science Cost Tweaker there is no intermediate lab technology.
  -- Unlock the vanilla lab from Sea Block's circuit-board startup milestone so
  -- the later automation-science trigger can still be driven by crafting a lab.
  bobmods.lib.tech.add_recipe_unlock("sb-startup3", "lab")
  bobmods.lib.recipe.enabled("lab", false)
end

if data.raw.technology["automation-science-pack"] then
  -- Science Cost Tweaker inserts "sct-lab-t1" between basic circuits and red
  -- science.  The non-SCT target set used for the Factorio 2.0 port does not
  -- have that technology, so wire red science to the startup milestone that
  -- unlocks the lab recipe instead of indexing a missing SCT prototype.
  local lab_prerequisite = sct_lab_tech and "sct-lab-t1" or "sb-startup3"
  -- This trigger technology is part of Sea Block's startup chain.  Keep its
  -- prerequisite list to the single lab milestone selected above so the
  -- no-SCT branch behaves like the SCT branch without adding a removed
  -- optional technology.
  data.raw.technology["automation-science-pack"].prerequisites = { lab_prerequisite }

  data.raw.technology["automation-science-pack"].research_trigger = { type = "craft-item", item = "lab" }
  data.raw.technology["automation-science-pack"].unit = nil
  if sct_lab_tech then
    sct_lab_tech.unit = {
      count = 1,
      ingredients = {},
      time = 1,
    }
  end
  seablock.lib.hide_technology("sb-startup4")
end

if sct_lab_tech then
  bobmods.lib.tech.remove_prerequisite("sct-lab-t1", "steam-power")
end

local movedrecipes = table.deepcopy(seablock.startup_recipes)
for k in pairs(seablock.scripted_techs) do
  if data.raw.technology[k] then
    for _, effect in pairs(data.raw.technology[k].effects or {}) do
      movedrecipes[effect.recipe] = true
    end
    bobmods.lib.tech.ignore_tech_cost_multiplier(k, true)
  end
end
local disabledrecipes = {}

-- Don't want any recipes available that consume our carefully
-- selected starting items until the self-sufficient startup is complete
local function consumes_startup_item(recipe)
  local found = false
  local ironnames = {
    ["iron-plate"] = true,
    ["iron-gear-wheel"] = true,
    ["iron-stick"] = true,
    ["pipe"] = true,
    ["pipe-to-ground"] = true,
    ["bob-basic-circuit-board"] = true,
    ["electronic-circuit"] = true,
    ["stone-brick"] = true,
    ["copper-plate"] = true,
    ["copper-cable"] = true,
    ["stone-furnace"] = true,
  }
  for _, v in pairs(recipe.ingredients or {}) do
    if ironnames[v.name] then
      found = true
      break
    end
  end
  return found
end

-- Disable recipes that shouldn't consume startup items
for k, v in pairs(data.raw.recipe) do
  if (v.enabled == nil or v.enabled == true) and consumes_startup_item(v) and not v.hidden then
    if not movedrecipes[k] then
      table.insert(disabledrecipes, k)
    end
    bobmods.lib.recipe.enabled(k, false)
  end
end

-- Add prerequisites to technologies which are not part of the selected startup techs.
for tech_name, tech in pairs(data.raw.technology) do
  if
    (tech.enabled == nil or tech.enabled == true or tech.enabled == "true") and not seablock.scripted_techs[tech_name]
  then
    if not tech.prerequisites or #tech.prerequisites == 0 then
      local prerequisite = seablock.final_startup_tech
      if seablock.startup_techs[tech_name] then
        prerequisite = seablock.final_scripted_tech
      end
      tech.prerequisites = { prerequisite }
    end
  end
  if tech.effects and not seablock.scripted_techs[tech_name] then
    local neweffects = {}
    for _, effect in pairs(tech.effects) do
      if effect.type ~= "unlock-recipe" or not movedrecipes[effect.recipe] then
        table.insert(neweffects, effect)
      end
    end
    tech.effects = neweffects
  end
end

-- Disabled recipes are enabled at last stage of startup. (Laboratory research)
for _, v in pairs(disabledrecipes) do
  bobmods.lib.tech.add_recipe_unlock(seablock.final_scripted_tech, v)
end
for k, _ in pairs(seablock.startup_recipes) do
  if data.raw.recipe[k] then
    bobmods.lib.recipe.enabled(k, true)
  end
end

-- Limit research required for startup techs.
for k, v in pairs(seablock.startup_techs) do
  if data.raw.technology[k] then
    if data.raw.technology[k].unit then
      if v[1] and data.raw.technology[k].unit.count > 20 then
        data.raw.technology[k].unit.count = 20
        data.raw.technology[k].unit.ingredients = { { "automation-science-pack", 1 } }
      end
      bobmods.lib.tech.ignore_tech_cost_multiplier(k, true)
      data.raw.technology[k].unit.time = 15
    end
  end
end

-- Make bio-wood-processing a startup tutorial tech
data.raw.technology["angels-bio-wood-processing"].prerequisites = { "sb-startup1" }
data.raw.technology["angels-bio-wood-processing"].unit = {
  count = 1,
  ingredients = {},
  time = 1,
}

-- Remove cycle introduced in the tech tree
-- Sectoid upgraded angelsbioprocessing by renaming the old prerequisite "basic-automation" into "electronics"
bobmods.lib.tech.remove_prerequisite("angels-basic-chemistry", "electronics")
bobmods.lib.tech.remove_prerequisite("angels-bio-processing-brown", "electronics")
bobmods.lib.tech.add_prerequisite("angels-bio-processing-brown", "automation")
