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
    local merit = master:getMerit(tpz.merit.RADIAL_ARCANA)
    local base = pet:getMainLvl() *3
    local baguaBonus = 0 -- TODO: add mods for Bagua Sandals/+1 (not in yet).
    local mpRestore = 0

    --* Bagua Sandals/+1 bonus such that with 1/5 merits, baguaBonus = 05; and 5/5 merits, baguaBonus = 25. (05/merit)
    mpRestore = math.floor(base *(1.0 +(0.3 *(merit -1)) +1)*(1.0 + baguaBonus))

    if (target:getMP()+mpRestore > target:getMaxMP()) then
        mpRestore = target:getMaxMP() - target:getMP()
    end
    
    target:addMP(mpRestore) 
    skill:setMsg(tpz.msg.basic.RECOVERS_MP)
    pet:timer(1000, function(mob) mob:setHP(0) end)
    return mpRestore
end
