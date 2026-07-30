-- TODO: Remove this file. Changes should now be in Angel's

-- Clay Brick prerequisites
-- These changes are not yet in Angel's.
bobmods.lib.tech.add_prerequisite("angels-advanced-ore-refining-1", "angels-stone-smelting-1")
bobmods.lib.tech.add_prerequisite("fluid-handling", "angels-stone-smelting-1")

-- Titanium prerequisites
-- These changes are not yet in Angel's.
bobmods.lib.tech.add_prerequisite("angels-advanced-chemistry-3", "bob-titanium-processing")

-- Reinforced concrete brick
-- These changes are not yet in Angel's.
bobmods.lib.tech.add_prerequisite("angels-advanced-chemistry-3", "angels-stone-smelting-3")

-- Copper tungsten / tungsten carbide prerequisites
-- These changes are not yet in Angel's.
-- Ore processing 4 already depends on tungsten processing, is this really necessary to have?
bobmods.lib.tech.add_prerequisite("angels-ore-processing-5", "bob-tungsten-processing")

-- Advanced circuit
-- These changes are not yet in Angel's.
bobmods.lib.tech.add_prerequisite("tank", "advanced-circuit")
