-----------------------------------
-- Pax
-- Reduces Enmity Generation (Enmity -)
-- note: Value should be Negative in Item/Spell Script
-----------------------------------

function onEffectGain(target, effect)
    local power = effect:getPower()
    target:addMod(tpz.mod.ENMITY, power)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local power = effect:getPower()
    target:delMod(tpz.mod.ENMITY, power)
end
