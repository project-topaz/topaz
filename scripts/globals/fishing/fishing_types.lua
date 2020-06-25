fishing = fishing or {}

fishing.coinFlip =
{
    TAILS       = 1,
    HEADS       = 2,
}

fishing.hookType =
{
    NONE        = 0,
    FISH        = 1,
    ITEM        = 2,
    MOB         = 3,
}

fishing.hookSenseType =
{
    SMALL       = 0,
    LARGE       = 1,
    KEENSMALL   = 2,
    KEENLARGE   = 3,
}

fishing.senseType =
{
    NONE                       = 0,
    GOOD                       = 1,
    BAD                        = 2,
    TERRIBLE                   = 3,
    NOSKILL_FEELING            = 4,
    NOSKILL_SURE_FEELING       = 5,
    NOSKILL_POSITIVEFEELING    = 6,
    KEEN_ANGLERS_SENSE         = 7,
    EPIC_CATCH                 = 8,
}

fishing.catchType =
{
    NONE            = 0,
    SMALLFISH       = 1,
    BIGFISH         = 2,
    ITEM            = 3,
    MOB             = 4,
    CHEST           = 5,
    SMALL_CUSTOM    = 6,
    LARGE_CUSTOM    = 7,
    MOB_CUSTOM      = 8,
}

fishing.successType =
{
    NONE                = 0,
    CATCHITEM           = 1,
    CATCHSMALL          = 2,
    CATCHLARGE          = 3,
    CATCHLEGEND         = 4,
    CATCHMOB            = 5,
    LINEBREAK           = 6,
    RODBREAK            = 7,
    LOSTCATCH           = 8,
    CATCHCHEST          = 9,
    CATCHSMALL_CUSTOM   = 10,
    CATCHLARGE_CUSTOM   = 11,
    CATCHMOB_CUSTOM     = 12,
}

fishing.failType =
{
    NONE                = 0,
    SYSTEM              = 1,
    LINESNAP            = 2,
    RODBREAK            = 3,
    RODBREAK_TOOBIG     = 4,
    RODBREAK_TOOHEAVY   = 5,
    LOST                = 6,
    LOST_TOOSMALL       = 7,
    LOST_LOWSKILL       = 8,
    LOST_TOOBIG         = 9,
}

fishing.sizeType =
{
    SMALL       = 0,
    LARGE       = 1,
    LEGENDARY   = 2,
}

fishing.fishFlag =
{
    NORMAL         = 0x00,
    HALF_SIZE      = 0x01,
    BOTTOM_FEEDER  = 0x02,
    TROPICAL       = 0x04,
    RUSTY          = 0x08,
    DOUBLE_SIZE    = 0x10
}

fishing.lureFlag =
{
    NORMAL          = 0x00,
    SINKING         = 0x01,
    ITEM_BONUS      = 0x02,
    ITEM_MEGA_BONUS = 0x04
}

fishing.rodFlag =
{
    NORMAL          = 0x00,
    SMALL_PENALTY   = 0x01,
    LARGE_PENALTY   = 0x02,
    LEGENDARY_BONUS = 0x04,
}

fishing.legendaryFlag =
{
    NORMAL                  = 0x00,
    HALF_TIME               = 0x01,
    NO_ROD_TIME_BONUS       = 0x02,
    EBISU_TIME_BONUS_ONLY   = 0x04,
    ADD_TIME_MULTIPLIER     = 0x08,
}

fishing.rodLegendType =
{
    NONE        = 0,
    LUSHANG     = 1,
    EBISU       = 2,
}

fishing.rodMaterial =
{
    WOOD        = 0,
    SYNTHETIC   = 1,
}

fishing.waterType =
{
    ALL         = 0,
    FRESH       = 1,
    SALT        = 2,
}

fishing.timePref =
{
    ALL         = 0,
    DAY         = 1,
    NIGHT       = 2,
}

fishing.moonPref =
{
    ALL         = 0,
    FULL        = 1,
    NEW         = 2,
}

fishing.locationType =
{
    ALL         = 0,
    CITY        = 1,
    OUTSIDE     = 2,
}

fishing.nmFlag =
{
    NORMAL                            = 0x00,
    RANDOM_REGEN_EASY                 = 0x01,
    RANDOM_REGEN_DIFFICULT            = 0x02,
    RANDOM_HEAL_EASY                  = 0x04,
    RANDOM_HEAL_DIFFICULT             = 0x08,
    RANDOM_ATTACK_EASY                = 0x10,
    RANDOM_ATTACK_DIFFICULT           = 0x20,
    RESET_RESPAWN_ON_FAIL             = 0x40,
}