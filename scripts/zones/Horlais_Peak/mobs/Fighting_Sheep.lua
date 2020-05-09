-----------------------------------
-- Area: Horlais Peak
--  Mob: Fighting Sheep
-- BCNM: Hostile Herbivores
-- TODO: melee attacks cause knockback.
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.ICESDT,      750)
    mob:setMod(tpz.mod.FIRESDT,    1250)
    mob:setMod(tpz.mod.THUNDERSDT, 1250)
end

function onMobDeath(mob, player, isKiller)
end
