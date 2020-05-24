-----------------------------------
-- Ability: Lasting Emanation
-- Reduces the amount of HP your luopan consumes.
-- Obtained: Geomancer Level 25
-- Recast Time: 00:05:00
-- Duration: N/A
-- Notes: Base HP drain rate is 24 HP/tic. With Lasting Emenation it is 17HP/tic.
-- Operates on a shared recast timer with Ecliptic Attrition.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player,target,ability)
    if not player:hasPet() or not player:getPetID() == 75 then
        return tpz.msg.basic.REQUIRE_LUOPAN, 0
    end
    return 0,0
end

function onUseAbility(player,target,ability)
    local luopan = player:getPet()
    local luopanLvl = luopan:getMainLvl()
    player:getPet():addStatusEffect(tpz.effect.LASTING_EMANATION, math.floor(luopanLvl / 15), 0, 0)
end
