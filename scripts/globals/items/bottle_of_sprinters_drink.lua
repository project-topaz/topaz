-----------------------------------------
-- ID: 5397
-- Item: Sprinter's Drink
-- Item Effect: Quickening for 1 minute
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.QUICKENING, 100, 0, 60)
    target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.QUICKENING)
end
