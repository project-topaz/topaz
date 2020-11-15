-----------------------------------------
-- ID: 5849
-- Item: bottle_of_berserkers_drink
-- Item Effect: Double Attack +100
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local ename = tpz.effect.MULTI_STRIKES
    local power = 100 --DA
    local duration = 60

    if target:hasStatusEffect(ename) then
        local buff = target:getStatusEffect(ename)
        local effectpower = buff:getPower()
        if effectpower > power then
            target:messageBasic(tpz.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(ename, power, 0, duration, 0, subp)
        end
    else
        target:addStatusEffect(ename, power, 0, duration, 0, subp)
    end
end
