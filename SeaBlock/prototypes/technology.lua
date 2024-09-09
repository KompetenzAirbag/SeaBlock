data:extend({
  {
    type = "tool",
    name = "sb-checkpoint",
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = { "hidden" },
    stack_size = 1,
    durability = 1,
  },
  -- Checkpoint: Make Mud (or Saline water?)
  {
    type = "technology",
    name = "sb-checkpoint-mud",
    icon = "__angelsrefining__/graphics/icons/solid-mud.png",
    icon_size = 32,
    unit = {
      count = 1,
      ingredients = { { "sb-checkpoint", 1 } },
      time = 1,
    },
  },
  -- Checkpoint: Make Landfill (of any flavour)
  {
    type = "technology",
    name = "sb-checkpoint-landfill",
    icon = "__base__/graphics/technology/landfill.png",
    icon_size = 256,
    icon_mipmaps = 4,
    unit = {
      count = 1,
      ingredients = { { "sb-checkpoint", 1 } },
      time = 1,
    },
  },
  -- Checkpoint: Make Charcoal
  {
    type = "technology",
    name = "sb-checkpoint-charcoal",
    icon = "__angelsbioprocessing__/graphics/icons/wood-charcoal.png",
    icon_size = 32,
    unit = {
      count = 1,
      ingredients = { { "sb-checkpoint", 1 } },
      time = 1,
    },
  },
  -- Checkpoint: Make an Iron Plate
  {
    type = "technology",
    name = "sb-checkpoint-iron-plate",
    icon = "__base__/graphics/icons/iron-plate.png",
    icon_size = 64,
    icon_mipmaps = 4,
    unit = {
      count = 1,
      ingredients = { { "sb-checkpoint", 1 } },
      time = 1,
    },
  },
  -- Checkpoint: Make Soil
  {
    type = "technology",
    name = "sb-checkpoint-soil",
    icon = "__angelsbioprocessing__/graphics/icons/solid-soil.png",
    icon_size = 32,
    unit = {
      count = 1,
      ingredients = { { "sb-checkpoint", 1 } },
      time = 1,
    },
  },
  -- Checkpoint: Make Wood
  {
    type = "technology",
    name = "sb-checkpoint-wood",
    icon = "__base__/graphics/icons/wood.png",
    icon_size = 64,
    icon_mipmaps = 4,
    unit = {
      count = 1,
      ingredients = { { "sb-checkpoint", 1 } },
      time = 1,
    },
  },
  -- Checkpoint: Make a Basic Circuit
  {
    type = "technology",
    name = "sb-checkpoint-basic-circuit",
    icon = "__SeaBlock__/graphics/technology/basic-circuit-board.png",
    icon_size = 128,
    unit = {
      count = 1,
      ingredients = { { "sb-checkpoint", 1 } },
      time = 1,
    },
  },
  -- Lab technology
  {
    type = "technology",
    name = "sb-startup-lab",
    icon = "__SeaBlock__/graphics/technology/lab.png",
    icon_size = 128,
    effects = {
      { type = "unlock-recipe", recipe = "lab" },
      { type = "unlock-recipe", recipe = "automation-science-pack" },
    },
    unit = {
      count = 1,
      ingredients = {},
      time = 1,
    },
  },
  -- Checkpoint: Make an Electromagnetism Lab
  {
    type = "technology",
    name = "sb-checkpoint-lab",
    icon = "__SeaBlock__/graphics/technology/lab.png",
    icon_size = 128,
    unit = {
      count = 1,
      ingredients = { { "sb-checkpoint", 1 } },
      time = 1,
    },
  },

  {
    type = "technology",
    name = "sb-bio-processing-advanced",
    localised_name = { "technology-name.bio-processing-green" },
    localised_description = { "technology-description.bio-processing-green" },
    icon = "__angelsbioprocessing__/graphics/technology/algae-farm-tech.png",
    icon_size = 128,
    order = "c-a",
    prerequisites = {
      "bio-processing-red",
      "advanced-electronics",
      "angels-stone-smelting-2",
      "zinc-processing",
      "chemical-science-pack",
    },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "algae-farm-4",
      },
    },
    unit = {
      count = 50,
      ingredients = {
        { type = "item", name = "automation-science-pack", amount = 1 },
        { type = "item", name = "logistic-science-pack", amount = 1 },
        { type = "item", name = "token-bio", amount = 1 },
        { type = "item", name = "chemical-science-pack", amount = 1 },
      },
      time = 30,
    },
  },
  {
    type = "technology",
    name = "steam-power",
    icon = "__base__/graphics/icons/fluid/steam.png",
    icon_size = 64,
    icon_mipmaps = 4,
    prerequisites = {},
    effects = {
      {
        type = "unlock-recipe",
        recipe = "boiler",
      },
      {
        type = "unlock-recipe",
        recipe = "steam-engine",
      },
    },
    unit = {
      count = 10,
      ingredients = {
        { "automation-science-pack", 1 },
      },
      time = 10,
    },
    order = "a-a",
  },
})

-- TODO: Remove hard coded list of recipes. Instead disable any recipe which isn't in seablock.startup_recipes
for _, recipe in pairs({
  "angelsore1-crushed",
  "angelsore3-crushed",
  "automation-science-pack",
  "basic-circuit-board",
  "boiler",
  "copper-pipe-to-ground",
  "steam-engine",
  "stone-brick",
  "stone-furnace",
}) do
  bobmods.lib.recipe.enabled(recipe, false)
end

if mods["bobwarfare"] then
  data:extend({
    {
      type = "technology",
      name = "sb-sniper-rifle",
      localised_name = { "item-name.sniper-rifle" },
      icon_size = 256,
      icon_mipmaps = 4,
      icon = "__base__/graphics/technology/military.png",
      effects = {
        {
          type = "unlock-recipe",
          recipe = "sniper-rifle",
        },
      },
      prerequisites = { "military-science-pack" },
      unit = {
        count = 200,
        ingredients = {
          { "automation-science-pack", 1 },
          { "logistic-science-pack", 1 },
          { "military-science-pack", 1 },
        },
        time = 15,
      },
    },
  })
end
