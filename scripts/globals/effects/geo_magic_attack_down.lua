-----------------------------------
-- Effect: GEO Magic Attack Down
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target,effect)
    target:addMod(tpz.mod.MATT, -effect:getPower())
end

function onEffectTick(target,effect)
end

function onEffectLose(target,effect)
    target:delMod(tpz.mod.MATT, -effect:getPower())
end