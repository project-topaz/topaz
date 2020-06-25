require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/equipment")

fishing = fishing or {}

fishing.gear =
{
    -- body
    FISHERMANS_TUNICA   = 13808,
    ANGLERS_TUNICA      = 13809,
    FISHERMANS_APRON    = 14400,
    FISHERMANS_SMOCK    = 11337,
    -- hands
    FISHERMANS_GLOVES   = 14070,
    ANGLERS_GLOVES      = 14071,
    -- legs
    FISHERMANS_HOSE     = 14292,
    ANGLERS_HOSE        = 14293,
    -- feet
    FISHERMANS_BOOTS    = 14171,
    ANGLERS_BOOTS       = 14172,
    WADERS              = 14195,
}

fishing.bait =
{
    DRILL_CALAMARY      = 17006,
    DWARF_PUGIL         = 17007,
}

fishing.rings =
{
    PELICAN     = 15554,
    ALBATROSS   = 15555,
    PENGUIN     = 15556,
}

fishing.enchantments = {
    [fishing.rings.PELICAN] = {
        duration = 1200,
        mod = tpz.mod.PELICAN_RING_EFFECT,
        limit = 2,
    },
    [fishing.rings.ALBATROSS] = {
        duration = 1200,
        mod = tpz.mod.ALBATROSS_RING_EFFECT,
        limit = 2,
    },
    [fishing.rings.PENGUIN] = {
        duration = 1200,
        mod = tpz.mod.PENGUIN_RING_EFFECT,
        limit = 2,
    }
}
