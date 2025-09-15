local function add_category(type, entity_name, category)
  if (not data.raw["recipe-category"][category]) then
    error("Tried to add category to entity "..entity_name.." with type "..type..": Category does not exist")
  end

  if (not data.raw[type]) then
    error("Tried to add category to entity "..entity_name.." with type "..type..": Type does not exist")
  end

  if (not data.raw[type][entity_name]) then
    error("Tried to add category to entity "..entity_name.." with type "..type..": "..entity_name.." does not exist")
  end

  data.raw[type][entity_name].crafting_categories = data.raw[type][entity_name].crafting_categories or {}

  table.insert(data.raw[type][entity_name].crafting_categories, category)
end

-- crafting category "electronics" got removed from assembling machines since it is now part of Flugora
add_category("assembling-machine", "assembling-machine-1", "electronics")

add_category("assembling-machine", "assembling-machine-2", "electronics")
add_category("assembling-machine", "assembling-machine-2", "electronics-with-fluid")

add_category("assembling-machine", "assembling-machine-3", "electronics")
add_category("assembling-machine", "assembling-machine-3", "electronics-with-fluid")

add_category("assembling-machine", "bob-assembling-machine-4", "electronics")
add_category("assembling-machine", "bob-assembling-machine-4", "electronics-with-fluid")

add_category("assembling-machine", "bob-assembling-machine-5", "electronics")
add_category("assembling-machine", "bob-assembling-machine-5", "electronics-with-fluid")

add_category("assembling-machine", "bob-assembling-machine-6", "electronics")
add_category("assembling-machine", "bob-assembling-machine-6", "electronics-with-fluid")