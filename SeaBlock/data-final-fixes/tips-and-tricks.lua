-- Angel's replaces iron ore with saphirite ore in the "Low power" simulation, but Sea Block removes all ore resources.
-- Show two identical rows of inserters instead: the left one has enough power, the right one does not.
local low_power = data.raw["tips-and-tricks-item"]["low-power"]
if low_power then
  low_power.simulation = {
    init_update_count = 60,
    init = [[
      require("__core__/lualib/story")
      local surface = game.surfaces[1]

      player = game.simulation.create_test_player{name = "big k"}
      player.teleport({0, 4})
      game.simulation.camera_player = player
      game.simulation.camera_position = {0, -0.5}
      game.simulation.camera_zoom = 1.8
      game.simulation.camera_player_cursor_position = player.position

      -- Wind turbines come from KS Power, which is optional
      local has_wind_turbines = prototypes.entity["wind-turbine-2"] ~= nil

      local function add_wind_turbine_row(x, y, count)
        for i = 1, count do
          surface.create_entity{name = "wind-turbine-2", position = {x + i - (count + 1) / 2, y}, force = "player"}
        end
      end

      -- Wind turbines produce 15kW each and are split between a row below and a row above the inserters
      local function add_power(x, kilowatts)
        if has_wind_turbines then
          local count = kilowatts / 15
          add_wind_turbine_row(x, 2.5, math.ceil(count / 2))
          add_wind_turbine_row(x, -3.5, math.floor(count / 2))
        else
          local interface = surface.create_entity{name = "electric-energy-interface", position = {x + 0.5, 3}, force = "player"}
          interface.power_production = kilowatts * 1000 / 60
          interface.electric_buffer_size = kilowatts * 1000 / 60
        end
      end

      -- Inserters above and below move iron plates from infinite chests into the middle chests, which void them
      local function build_setup(x, kilowatts)
        for _, dx in pairs({-2, -1, 1, 2}) do
          local sink = surface.create_entity{name = "infinity-chest", position = {x + dx, -0.5}, force = "player"}
          sink.remove_unfiltered_items = true
          for _, row in pairs({
            {source_y = -2.5, inserter_y = -1.5, direction = defines.direction.north},
            {source_y = 1.5, inserter_y = 0.5, direction = defines.direction.south},
          }) do
            local source = surface.create_entity{name = "infinity-chest", position = {x + dx, row.source_y}, force = "player"}
            source.set_infinity_container_filter(1, {index = 1, name = "iron-plate", count = 50, mode = "at-least"})
            surface.create_entity{name = "inserter", position = {x + dx, row.inserter_y}, direction = row.direction, force = "player"}
          end
        end
        add_power(x, kilowatts)
        return surface.create_entity{name = "medium-electric-pole", position = {x, -0.5}, force = "player"}
      end

      build_setup(-6.5, 150)
      local low_power_pole = build_setup(6.5, 15)

      local story_table =
      {
        {
          {
            name = "start",
            condition = story_elapsed_check(4)
          },
          {
            condition = function() return game.simulation.move_cursor({position = low_power_pole.position, speed = 0.15}) end
          },
          {
            condition = story_elapsed_check(0.25),
            action = function() player.opened = low_power_pole end
          },
          {
            condition = function() return game.simulation.move_cursor({position = player.position, speed = 0.1}) end
          },
          {
            condition = story_elapsed_check(5),
            action = function()
              player.opened = nil
              story_jump_to(storage.story, "start")
              -- story_jump_to does not restart the step timer, so the wait at "start" would be skipped
              storage.story.current_story_started_at = game.tick
            end
          }
        }
      }
      tip_story_init(story_table)
    ]],
  }
end

-- The "Entity transfers" simulation mines coal and saphirite with burner drills, but Sea Block removes all ore resources.
-- Take charcoal and iron ore out of chests instead, put them into two furnaces, then take the plates out.
local entity_transfers = data.raw["tips-and-tricks-item"]["entity-transfers"]
if entity_transfers then
  entity_transfers.simulation = {
    init = [[
      require("__core__/lualib/story")
      player = game.simulation.create_test_player{name = "big k"}
      player.teleport({0, 2.5})
      game.simulation.camera_player = player
      game.simulation.camera_position = {0, 0.5}
      game.simulation.camera_alt_info = true
      game.simulation.camera_player_cursor_position = player.position

      local surface = game.surfaces[1]
      fuel_chest = surface.create_entity{name = "wooden-chest", position = {-4.5, -1.5}, force = "player"}
      ore_chest = surface.create_entity{name = "wooden-chest", position = {-4.5, 1.5}, force = "player"}
      furnaces = {
        surface.create_entity{name = "stone-furnace", position = {3, -1}, force = "player"},
        surface.create_entity{name = "stone-furnace", position = {5, -1}, force = "player"},
      }
      resting_position = {0, -1}

      fast_entity_transfer = function()
        game.simulation.control_press{control = "fast-entity-transfer", notify = true}
      end

      -- More than a stack is taken, so the cursor refills with the rest for the second furnace
      hold = function(item_name)
        local stack = player.get_main_inventory().find_item_stack(item_name)
        stack.swap_stack(player.cursor_stack)
      end

      local story_table =
      {
        {
          {
            name = "start",
            init = function()
              fuel_chest.clear_items_inside()
              fuel_chest.insert({name = "angels-wood-charcoal", count = 250})
              ore_chest.clear_items_inside()
              ore_chest.insert({name = "iron-ore", count = 280})
              for k, furnace in pairs (furnaces) do
                furnace.crafting_progress = 0
                furnace.clear_items_inside()
                furnace.get_output_inventory().insert({name = "iron-plate", count = 40})
              end
              player.clear_items_inside()
            end,
            condition = function() return game.simulation.move_cursor({position = fuel_chest.position}) end
          },
          {
            condition = story_elapsed_check(0.5),
            action = function() fast_entity_transfer() end
          },
          { condition = story_elapsed_check(1) },
          { condition = function() return game.simulation.move_cursor({position = resting_position}) end },
          {
            condition = story_elapsed_check(0.5),
            action = function() hold("angels-wood-charcoal") end
          },
          { condition = function() return game.simulation.move_cursor({position = furnaces[1].position, speed = 0.1}) end },
          {
            condition = story_elapsed_check(0.5),
            action = function() fast_entity_transfer() end
          },
          { condition = story_elapsed_check(1) },
          {
            condition = function() return game.simulation.move_cursor({position = furnaces[2].position, speed = 0.1}) end,
            action = function() fast_entity_transfer() end
          },
          { condition = story_elapsed_check(1) },
          { condition = function() return game.simulation.move_cursor({position = ore_chest.position}) end },
          {
            condition = story_elapsed_check(0.5),
            action = function() fast_entity_transfer() end
          },
          { condition = story_elapsed_check(1) },
          { condition = function() return game.simulation.move_cursor({position = resting_position}) end },
          {
            condition = story_elapsed_check(0.5),
            action = function() hold("iron-ore") end
          },
          { condition = function() return game.simulation.move_cursor({position = furnaces[1].position, speed = 0.1}) end },
          {
            condition = story_elapsed_check(0.5),
            action = function() fast_entity_transfer() end
          },
          { condition = story_elapsed_check(1) },
          {
            condition = function() return game.simulation.move_cursor({position = furnaces[2].position, speed = 0.1}) end,
            action = function() fast_entity_transfer() end
          },
          { condition = story_elapsed_check(1) },
          { condition = function() return game.simulation.move_cursor({position = resting_position}) end },
          { condition = story_elapsed_check(0.5) },
          { condition = function() return game.simulation.move_cursor({position = furnaces[1].position, speed = 0.1}) end },
          {
            condition = story_elapsed_check(0.5),
            action = function() fast_entity_transfer() end
          },
          { condition = story_elapsed_check(1) },
          {
            condition = function() return game.simulation.move_cursor({position = furnaces[2].position, speed = 0.1}) end,
            action = function() fast_entity_transfer() end
          },
          { condition = story_elapsed_check(1) },
          { condition = function() return game.simulation.move_cursor({position = player.position}) end },
          {
            condition = story_elapsed_check(2),
            action = function()
              story_jump_to(storage.story, "start")
              -- story_jump_to does not restart the step timer
              storage.story.current_story_started_at = game.tick
            end
          }
        }
      }
      tip_story_init(story_table)
    ]],
  }
end

-- Removing bob-resin and angels-natural-gas from tips and tricks
local function make_petrochem_description()
    local description = { "tips-and-tricks-description.sb-angels-petrochem" }

    local function get_item_from_name(item_name, item_type, before)
      before = before or "- "
      item_type = item_type or "item"
      return {
        "",
        before .. "[" .. "img=" .. item_type .. "/" .. item_name .. "] ",
        { item_type .. "-name." .. item_name },
        "\n",
      }
    end
    local one = { "" }
    table.insert(one, get_item_from_name("plastic-bar"))
    table.insert(one, get_item_from_name("explosives"))
    table.insert(one, get_item_from_name(data.raw.item["bob-rubber"] and "bob-rubber" or "angels-solid-rubber"))
    table.insert(one, get_item_from_name("sulfuric-acid", "fluid"))
    table.insert(one, { "", "- [img=item/solid-fuel]", " and various fuels", "\n" })
    table.insert(description, one)

    return description
end

data.raw["tips-and-tricks-item"]["angels-petrochem"].localised_description = make_petrochem_description()
