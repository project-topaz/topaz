-----------------------------------
-- Area: Davoi
--  Mob: Orcish Cursemaker
-- Note: PH for Hawkeyed Dnatbat
-----------------------------------
local ID = require("scripts/zones/Davoi/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.HAWKEYED_DNATBAT_PH, 10, math.random(3600,10800)) -- 1-3 hours.
end
