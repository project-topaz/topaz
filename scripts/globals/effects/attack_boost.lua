-----------------------------------
-- tpz.effect.ATTACK_BOOST
-- getPower()      = ATTP
-- getSubPower()   = RATTP
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    if effect:getPower() > 100 then --normalize values(?)
        effect:setPower(50)
    end
    if effect:getSubPower() > 100 then --normalize values(?)
        effect:setSubPower(50)
    end
    target:addMod(tpz.mod.ATTP, effect:getPower())
    if effect:getSubPower() > 0 then
        target:addMod(tpz.mod.RATTP, effect:getSubPower())
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ATTP, effect:getPower())
    if effect:getSubPower() > 0 then
        target:delMod(tpz.mod.RATTP, effect:getSubPower())
    end
end
