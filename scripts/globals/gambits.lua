-----------------------------------
-- Gambits decision making system
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------

ai = ai or {}

-- Target
ai.t =
{
    SELF   = 0,
    PARTY  = 1,
    TARGET = 2,
    MASTER = 3,
}

-- Condition
ai.c =
{
    ALWAYS           = 0,
    HPP_LT           = 1,
    HPP_GTE          = 2,
    MPP_LT           = 3,
    TP_LT            = 4,
    TP_GTE           = 5,
    STATUS           = 6,
    NOT_STATUS       = 7,
    STATUS_FLAG      = 8,
    HAS_ENMITY       = 9,
    NOT_HAS_ENMITY   = 10,
    SC_AVAILABLE     = 11,
    NOT_SC_AVAILABLE = 12,
    MB_AVAILABLE     = 13,
}

-- Reaction
ai.r =
{
    ATTACK = 0,
    ASSIST = 1,
    MA     = 2,
    JA     = 3,
    WS     = 4,
}

-- Select
ai.s =
{
    HIGHEST    = 0,
    LOWEST     = 1,
    SPECIFIC   = 2,
    RANDOM     = 3,
    MB_ELEMENT = 4,
}
