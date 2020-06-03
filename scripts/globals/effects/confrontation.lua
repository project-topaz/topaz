-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target,effect)
    if target:getPet() then
        target:getPet():addStatusEffect(effect)
    end

    if target:getObjType() == tpz.objType.PC then
        target:clearTrusts()
    end
end

function onEffectTick(target,effect)
end

function onEffectLose(target,effect)
    if target:getPet() then
        target:getPet():delStatusEffect(tpz.effect.CONFRONTATION)
    end
end
