-----------------------------------------
-- ID: 5394
-- Item: Bottle of Gnostic's Drink
-- Item Effect: Pax (Enmity Down)
-- Duration: 3 Mins
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if not target:hasStatusEffect(tpz.effect.PAX) then
        target:addStatusEffect(tpz.effect.PAX,-30,3,60)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end