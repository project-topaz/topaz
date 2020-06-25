-----------------------------------
-- Area: Pso'Xja
--  Mob: Diremite
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs");

function onMobDeath(mob, player, isKiller)
end;

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.GYRE_CARLIN_PH, 5, math.random(3600*4, 3600*5)) -- 4-5 hours.
end;
