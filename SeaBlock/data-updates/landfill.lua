-- Will need a lot of landfill
seablock.lib.substingredient("landfill", "stone", "angels-stone-crushed", 10)
for k, v in pairs(data.raw.item) do
  if string.sub(k, 1, 8) == "landfill" then
    v.stack_size = 1000
  end
end

local function strip_landfill_string(name)
  return name:gsub("^landfill%-", "")
end

-- Set prefered type for basic landfill crafting
if settings.startup["sb-default-landfill"] and data.raw.item[settings.startup["sb-default-landfill"].value] then
  data.raw.recipe["landfill"].results[1].name = settings.startup["sb-default-landfill"].value

  data.raw.recipe["landfill"].localised_name = {strip_landfill_string(settings.startup["sb-default-landfill"].value)..'-name.name'}
end

local function BuffLandfill(recipe)
  seablock.lib.substingredient(recipe, "angels-solid-mud", nil, 5)
  bobmods.lib.recipe.set_energy_required(recipe, 2)
  bobmods.lib.tech.remove_recipe_unlock("angels-water-washing-1", recipe)
  bobmods.lib.tech.add_recipe_unlock("landfill", recipe)
end

BuffLandfill("angels-solid-mud-landfill")

if mods["LandfillPainting"] then
  BuffLandfill("landfill-dry-dirt")
  BuffLandfill("landfill-dirt")
  BuffLandfill("landfill-grass")
  BuffLandfill("landfill-red-desert")
  BuffLandfill("landfill-sand")
else
  bobmods.lib.tech.remove_recipe_unlock("angels-water-washing-2", "angels-solid-mud-landfill")
end

-- Make landfill a red science tech
data.raw.technology["landfill"].prerequisites = { "angels-water-washing-1" }
data.raw.technology["landfill"].unit = {
  count = 10,
  ingredients = { { "automation-science-pack", 1 } },
  time = 15,
}
bobmods.lib.tech.remove_prerequisite("angels-water-washing-2", "landfill")
bobmods.lib.tech.ignore_tech_cost_multiplier("landfill", true)

local startup_landfill = "landfill"
local setting = settings.startup["sb-default-landfill"]

local item_tile_map = {
  ["landfill-dry-dirt"] = "dry-dirt",
  ["landfill-dirt"] = "dirt-4",
  ["landfill-grass"] = "grass-1",
  ["landfill-red-desert"] = "red-desert-1",
  ["landfill-sand"] = "sand-3",
  ["landfill"] = "landfill",
}

if setting and type(setting.value) == "string" then
  startup_landfill = item_tile_map[setting.value]
end

-- For blueprint pasting on water
data.raw.tile["water"].default_cover_tile = startup_landfill
data.raw.tile["deepwater"].default_cover_tile = startup_landfill

-- Adds SeaBlock tiles to tile condition so they can be replaced with landfill when placing 
if mods["LandfillPainting"] then
  local terrains = {
    "dry-dirt",
    "dirt",
    "grass",
    "red-desert",
    "sand"
  }

  local function get_landfill_name(name) do if name == "landfill" then return "landfill" else return "landfill-"..name end end end

  for _, name in pairs(terrains) do
    local landfill_name = get_landfill_name(name)

    if (data.raw.item[landfill_name].place_as_tile.tile_condition) then
      local tile_cond = data.raw.item[landfill_name].place_as_tile.tile_condition

      table.insert(tile_cond, "sand-4")
      table.insert(tile_cond, "sand-5")
    end
  end

  -- Default landfill recipe with stone
  local startup_landfill_no_num = get_landfill_name(startup_landfill):gsub("%-%d+$", "")

  data.raw.recipe["landfill"].results[1].name = startup_landfill_no_num
  data.raw.recipe["landfill"].localised_name = { "item-name."..startup_landfill_no_num }
end

-- Paste over sand-4 and -5
local tile_cond = data.raw.item["landfill"].place_as_tile.tile_condition

table.insert(tile_cond, "sand-4")
table.insert(tile_cond, "sand-5")
