-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOCALIZATION_AMOUNT, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOCALIZATION_AMOUNT, effect:getPower())
end
