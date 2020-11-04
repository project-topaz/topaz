-----------------------------------------
-- ID: 5394
-- Item: bottle_of_gnostics_drink
-- Item Effect: Enmity -
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local power = -10 -- Power Level unknown, using Animus Minueo Value as baseline.
    local duration = 60

    if (not target:hasStatusEffect(tpz.effect.PAX)) then
        target:addStatusEffect(tpz.effect.PAX, power, 0, duration)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
