-----------------------------------
-- Potency
-- Adds Haste + Critical Hit Rate
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HASTE_MAGIC, effect:getPower())
    target:addMod(tpz.mod.CRITHITRATE, effect:getSubPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HASTE_MAGIC, effect:getPower())
    target:delMod(tpz.mod.CRITHITRATE, effect:getSubPower())
end
