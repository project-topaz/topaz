-----------------------------------
--
-- tpz.effect.EBULLENCE
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.EBULLIENCE_AMOUNT, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.EBULLIENCE_AMOUNT, effect:getPower())
end
