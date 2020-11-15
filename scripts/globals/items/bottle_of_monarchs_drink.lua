-----------------------------------------
-- ID: 5393
-- Item: bottle_of_monarchs_drink
-- Item Effect: Regain
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local power = 3
    local duration = 180

    if (not target:hasStatusEffect(tpz.effect.REGAIN)) then
        target:addStatusEffect(tpz.effect.REGAIN, power, 0, duration)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
