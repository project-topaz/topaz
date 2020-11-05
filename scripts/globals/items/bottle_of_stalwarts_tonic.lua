-----------------------------------------
-- ID: 5839
-- Item: bottle_of_stalwarts_tonic
-- Item Effect: ATTP +25
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local name1 = tpz.effect.ACCURACY_BOOST
    local name2 = tpz.effect.ATTACK_BOOST
    local power1 = 50 --ACC/RACC
    local power2 = 25 --ATTP/RATTP
    local duration = 300

    if target:hasStatusEffect(name1) then
        local buff = target:getStatusEffect(name1)
        local effectpower = buff:getPower()
        if effectpower > power1 then
            target:messageBasic(tpz.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(name1, power1, 0, duration, 0, power1)
        end
    else
        target:addStatusEffect(name1, power1, 0, duration, 0, power1)
    end

    if target:hasStatusEffect(name2) then
        local buff = target:getStatusEffect(name2)
        local effectpower = buff:getPower()
        if effectpower > power2 then
            target:messageBasic(tpz.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(name2, power2, 0, duration, 0, power2)
        end
    else
        target:addStatusEffect(name2, power2, 0, duration, 0, power2)
    end
end
