-----------------------------------------
-- ID: 5392
-- Item: bottle_of_champions_drink
-- Item Effect: Haste (Magic) 18% - CRITHITRATE 5%
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local ename = tpz.effect.POTENCY
    local power = 180 --haste
    local subp = 5 --crit
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
