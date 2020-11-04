-----------------------------------------
-- ID: 5842
-- Item: bottle_of_ascetics_gambir
-- Item Effect: MAGIC_ATK_BOOST 50
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local ename = tpz.effect.MAGIC_ATK_BOOST
    local power = 50
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
