-----------------------------------
-- Area: Abyssea-Empyreal_Paradox
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ABYSSEA_EMPYREAL_PARADOX] =
{
    text =
    {
        -- General Texts
        ITEM_CANNOT_BE_OBTAINED     = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6388, -- Obtained: <item>.
        GIL_OBTAINED                = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6391, -- Obtained key item: <keyitem>.
        CRUOR_TOTAL                 = 6986, -- Obtained <number> cruor. (Total: <number>)

        -- Abyssea Weakness Targeting
        STAGGERED                   = 7316, -- <name>'s attack staggers the fiend!
        YELLOW_STAGGER              = 7317, -- The fiend is unable to cast magic.
        BLUE_STAGGER                = 7318, -- The fiend is unable to use special attacks.
        RED_STAGGER                 = 7319, -- The fiend is frozen in its tracks.
        YELLOW_WEAKNESS             = 7320, -- The fiend appears vulnerable to <0-7>[/fire/ice/wind/earth/lightning/water/light/darkness] elemental magic
        BLUE_WEAKNESS               = 7321, -- The fiend appears vulnerable to <0-14>[/hand-to-hand/dagger/sword/great sword/axe/great axe/scythe/polearm/katana/great katana/club/staff/archery/marksmanship] weapon skills
        RED_WEAKNESS                = 7322, -- The fiend appears vulnerable to <0-7>[/fire/ice/wind/earth/lightning/water/light/darkness] elemental weapon skills
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.ABYSSEA_EMPYREAL_PARADOX]
