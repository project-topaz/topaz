-----------------------------------
-- Area: Abyssea - Konschtat
--  Mob: Shadow Lizard
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    if math.random(1,3) >= 2 then
        DropLights(player, 0, 1, tpz.abyssea.lightType.SILVERY)
    end
end