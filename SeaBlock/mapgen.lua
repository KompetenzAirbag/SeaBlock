data.raw.tile["sand-4"] = table.deepcopy(data.raw.tile["sand-1"])
data.raw.tile["sand-5"] = table.deepcopy(data.raw.tile["sand-2"])
data.raw.tile["sand-4"].name = "sand-4"
data.raw.tile["sand-5"].name = "sand-5"

data.raw.tile["dry-dirt"].vehicle_friction_modifier = 1.8
data.raw.tile["dirt-1"].vehicle_friction_modifier = 1.8
data.raw.tile["dirt-2"].vehicle_friction_modifier = 1.8
data.raw.tile["dirt-3"].vehicle_friction_modifier = 1.8

data.raw.tile["dirt-4"].vehicle_friction_modifier = 1.8
data.raw.tile["dirt-5"].vehicle_friction_modifier = 1.8
data.raw.tile["dirt-6"].vehicle_friction_modifier = 1.8
data.raw.tile["dirt-7"].vehicle_friction_modifier = 1.8

data.raw.tile["grass-1"].vehicle_friction_modifier = 1.8
data.raw.tile["grass-3"].vehicle_friction_modifier = 1.8
data.raw.tile["grass-2"].vehicle_friction_modifier = 1.8
data.raw.tile["grass-4"].vehicle_friction_modifier = 1.8

data.raw.tile["red-desert-0"].vehicle_friction_modifier = 1.8
data.raw.tile["red-desert-1"].vehicle_friction_modifier = 1.8
data.raw.tile["red-desert-2"].vehicle_friction_modifier = 1.8
data.raw.tile["red-desert-3"].vehicle_friction_modifier = 1.8

data.raw.tile["sand-1"].vehicle_friction_modifier = 1.8
data.raw.tile["sand-2"].vehicle_friction_modifier = 1.8
data.raw.tile["sand-3"].vehicle_friction_modifier = 1.8
data.raw.tile["sand-4"].vehicle_friction_modifier = 1.8
data.raw.tile["sand-5"].vehicle_friction_modifier = 1.8

data.raw.tile["landfill"].vehicle_friction_modifier = 1.8

for _, v in pairs(data.raw.tile) do
    v.autoplace = nil
end

data.raw.cliff["cliff"].collision_mask = { not_colliding_with_itself = true, layers = { object = true, train = true}}

data:extend({
    {
        type = "noise-expression",
        name = "waterline",
        expression = "10"
    },
    {
        type = "noise-expression",
        name = "distance_sigmoid", -- sigmoid to gradually increase island size while limiting the maximum size
        local_expressions = {
            amount = "3.5",
            offset = "500",
            scale = "300"
        },
        expression = "amount/(1+e^(-(distance-offset)/scale))"
    },
    {
        type = "noise-function",
        name = "random_tree_islands",
        parameters = { "seed", "noise_seed", "frequency" },
        local_expressions = {
            base = "basis_noise{x = x, y = y, seed0 = map_seed, seed1 = noise_seed, input_scale = 1.99995}",
            multoctave = "multioctave_noise{x = x, y = y, persistence = 0.75, seed0 = map_seed, seed1 = seed, octaves = 3, input_scale = 1/32, output_scale = 10} * (1+frequency)"
        },
        expression = "if(multoctave >= 16, base, -inf)"
    },
    {
        type = "noise-function",
        name = "random_garden_islands",
        parameters = { "seed", "noise_seed", "frequency" },
        local_expressions = {
            base = "basis_noise{x = x, y = y, seed0 = map_seed, seed1 = noise_seed, input_scale = 1.99995}",
            multoctave = "multioctave_noise{x = x, y = y, persistence = 0.75, seed0 = map_seed, seed1 = seed, octaves = 3, input_scale = 1/32, output_scale = 10} * (1+frequency)"
        },
        expression = "if(multoctave >= 20, base, -inf)"
    }
})

-- cant put that in data:extend since elevation exists in base game
local elevation = data.raw["noise-expression"]["elevation"]

elevation.local_expressions = {
    base = "basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 5, input_scale = 1/32, output_scale = 6}",
    starting_tile = "if(distance <= 1, 100, 0)",
}

elevation.expression = "if(distance <= starting_area_radius/2, min(base - waterline, 0), base - waterline) + starting_tile + distance_sigmoid+1"

------- Tiles -------
-- Water
seablock.lib.set_probability_expression("tile", "deepwater", "if(elevation <= -8, elevation*-1, -inf)")
seablock.lib.set_probability_expression("tile", "water", "if(elevation < 0, elevation*-1, -inf)")

-- Beaches
seablock.lib.set_probability_expression("tile", "sand-4", "if(elevation >= 0, elevation, -inf)")

-- Landmass
seablock.lib.set_probability_expression("tile", "sand-5", "if(elevation >= 1.2, inf, -inf)")

------- Trees -------
-- Trees should only spawn on sand-5 which is the middle of each island
for _, name in pairs({ "angels-desert-garden", "angels-temperate-garden", "angels-swamp-garden", "angels-desert-tree", "angels-temperate-tree", "angels-swamp-tree", "angels-puffer-nest" }) do
    seablock.lib.set_tile_restriction("tree", name, "sand-5")
end

seablock.lib.set_probability_expression("tree", "angels-desert-garden", "random_garden_islands(1, 1, 0.4)")
seablock.lib.set_probability_expression("tree", "angels-desert-tree", "random_tree_islands(1, 2, 0.4)")

seablock.lib.set_probability_expression("tree", "angels-temperate-garden", "random_garden_islands(2, 1, 0.6)")
seablock.lib.set_probability_expression("tree", "angels-temperate-tree", "random_tree_islands(2, 2, 0.6)")

seablock.lib.set_probability_expression("tree", "angels-swamp-garden", "random_garden_islands(3, 1, 0.5)")
seablock.lib.set_probability_expression("tree", "angels-swamp-tree", "random_tree_islands(3, 2, 0.5)")

seablock.lib.set_probability_expression("tree", "angels-puffer-nest", "random_tree_islands(4, 1, 0.35)")