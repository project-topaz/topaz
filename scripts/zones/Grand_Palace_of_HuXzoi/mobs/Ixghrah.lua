-----------------------------------
-- Area: Grand Palace of HuXzoi
--  Mob: Ix'ghrah
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/missions")
-----------------------------------

function onMobSpawn(mob)
    if (mob:getMod(tpz.mod.SLASHSDT)) then mob:setMod(tpz.mod.SLASHSDT, 1000); end
    if (mob:getMod(tpz.mod.PIERCESDT)) then mob:setMod(tpz.mod.PIERCESDT, 1000); end
    if (mob:getMod(tpz.mod.IMPACTSDT)) then mob:setMod(tpz.mod.IMPACTSDT, 1000); end
    if (mob:getMod(tpz.mod.HTHSDT)) then mob:setMod(tpz.mod.HTHSDT, 1000); end
end;

function onMobFight(mob, target)
    local changeTime = mob:getLocalVar("changeTime")

    if (mob:getBattleTime() - changeTime > 60) then
        mob:AnimationSub(math.random(0, 3))
        mob:setLocalVar("changeTime", mob:getBattleTime())
    end
end

function onMobDeath(mob, player, isKiller)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.A_FATE_DECIDED  and player:getCharVar("PromathiaStatus")==1) then
        player:setCharVar("PromathiaStatus", 2)
    end
end
