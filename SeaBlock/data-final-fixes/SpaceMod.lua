if not mods["SpaceMod"] then
  return
end

if settings.startup["SpaceX-ignore-tech-multiplier"] then
  if settings.startup["SpaceX-ignore-tech-multiplier"].value then
    for _, tech_name in pairs({
      "ftl-theory-A",
      "ftl-theory-B",
      "ftl-theory-C",
      "ftl-theory-D",
      "ftl-theory-D1",
      "ftl-theory-D2",
      "ftl-propulsion",
    }) do
      bobmods.lib.tech.ignore_tech_cost_multiplier(tech_name, true)
    end
  else
    for _, tech_name in pairs({
      "space-assembly",
      "space-construction",
      "space-casings",
      "protection-fields",
      "fusion-reactor",
      "space-thrusters",
      "fuel-cells",
      "habitation",
      "life-support-systems",
      "spaceship-command",
      "astrometrics",
    }) do
      local tech = data.raw.technology[tech_name]

      if tech then
        tech.unit.count = tech.unit.count / 4
      end
    end
  end
end

local techs = {
  "space-assembly",
  "space-construction",
  "space-casings",
  "protection-fields",
  "fusion-reactor",
  "space-thrusters",
  "fuel-cells",
  "habitation",
  "life-support-systems",
  "spaceship-command",
  "astrometrics",
  "ftl-theory-A",
  "ftl-theory-B",
  "ftl-theory-C",
  "ftl-theory-D",
  "ftl-theory-D1",
  "ftl-theory-D2",
  "ftl-propulsion",
}

-- ftl-theory-D means SpaceMod bob's mode has activated
if data.raw.technology["ftl-theory-D"] then
  for _, tech in pairs(techs) do
    if data.raw.technology[tech] then
      data.raw.technology[tech].unit.count = data.raw.technology[tech].unit.count / 10
    end
  end

  if mods["bobtech"] then
    bobmods.lib.tech.add_science_pack("ftl-theory-D2", "bob-advanced-logistic-science-pack", 1)
    bobmods.lib.tech.remove_prerequisite("ftl-theory-D1", "ftl-theory-D")
    bobmods.lib.tech.add_prerequisite("ftl-theory-D1", "ftl-theory-C")
    bobmods.lib.tech.add_prerequisite("ftl-theory-D2", "ftl-theory-D")
  end
end
