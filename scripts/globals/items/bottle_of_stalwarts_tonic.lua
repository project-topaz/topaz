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
    local ename = tpz.effect.ATTACK_BOOST
    local power = 25
    local duration = 300

    if target:hasStatusEffect(ename) then
        local buff = target:getStatusEffect(ename)
        local effectpower = buff:getPower()
        if effectpower > power then
            target:messageBasic(tpz.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(ename, power, 0, duration)
        end
    else
        target:addStatusEffect(ename, power, 0, duration)
    end
end
