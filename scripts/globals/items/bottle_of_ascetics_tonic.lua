-----------------------------------------
-- ID: 5841
-- Item: bottle_of_ascetics_tonic
-- Item Effect: MATT/MACC 25
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local name1 = tpz.effect.MAGIC_ATK_BOOST
    local name2 = tpz.effect.INTENSION
    local power1 = 25 --MATT
    local power2 = 25 --MACC
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
