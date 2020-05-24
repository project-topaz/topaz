---------------------------------------------
-- Mending Halation
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0,0
end

function onPetAbility(target, pet, skill)
    local master = pet:getMaster()
    local merit = master:getMerit(tpz.merit.MENDING_HALATION)
    local base = pet:getMainLvl() *7
    local cure = 0

    cure = math.floor(base *(1.0 +(0.5 *(merit -1)) +1)) --*Relic Pants Bonus

    if (target:getHP()+cure) > target:getMaxHP() then
        cure = target:getMaxHP() - target:getHP()
    end

    target:wakeUp()
    target:addHP(cure)
        
    skill:setMsg(tpz.msg.basic.RECOVERS_HP)
    master:updateEnmityFromCure(target,cure)
    pet:timer(1000, function(mob) mob:setHP(0) end)
    return cure
end
