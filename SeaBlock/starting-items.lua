seablock = seablock or {}

function seablock.populate_starting_items(items)
  -- Bob Logistics dev migrated its stone pipes back into the base pipe names,
  -- while older Sea Block/Bob combinations may still expose Bob or Angel stone
  -- pipe prototypes.  Keep the base pipe starter stack below, but resolve the
  -- extra stone-pipe starter stack against whichever prototype actually loaded.
  -- This prevents the scripted first-hour bootstrap from granting removed items.
  local extra_pipe = "pipe"
  if items["angels-stone-pipe"] then
    extra_pipe = "angels-stone-pipe"
  elseif items["bob-stone-pipe"] then
    extra_pipe = "bob-stone-pipe"
  end

  local extra_pipe_to_ground = "pipe-to-ground"
  if items["angels-stone-pipe-to-ground"] then
    extra_pipe_to_ground = "angels-stone-pipe-to-ground"
  elseif items["bob-stone-pipe-to-ground"] then
    extra_pipe_to_ground = "bob-stone-pipe-to-ground"
  end

  local starting_items = {
    ["stone"] = 130,
    ["small-electric-pole"] = 50,
    ["small-lamp"] = 12,
    ["iron-plate"] = 1200,
    ["bob-basic-circuit-board"] = 200,
    ["stone-brick"] = 500,
    ["pipe"] = 21,
    ["bob-copper-pipe"] = 5,
    ["iron-gear-wheel"] = 10,
    ["iron-stick"] = 88,
    ["pipe-to-ground"] = 2,
  }
  starting_items[extra_pipe] = (starting_items[extra_pipe] or 0) + 100
  starting_items[extra_pipe_to_ground] = (starting_items[extra_pipe_to_ground] or 0) + 50

  -- Starting power production
  if items["wind-turbine-2"] then
    starting_items["wind-turbine-2"] = 120
  else
    starting_items["solar-panel"] = 38
    starting_items["accumulator"] = 32
  end

  -- Starting landfill
  local landfill
  local setting = settings.startup["sb-default-landfill"]
  if setting and items[setting.value] then
    landfill = setting.value
  else
    landfill = "landfill"
  end
  starting_items[landfill] = 2000
  return starting_items
end
