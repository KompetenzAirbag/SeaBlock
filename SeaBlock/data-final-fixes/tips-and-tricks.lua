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
      game.simulation.camera_zoom = 0.9
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
            condition = story_elapsed_check(5)
          },
          {
            condition = function() return game.simulation.move_cursor({position = low_power_pole.position, speed = 0.1}) end
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
