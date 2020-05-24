-----------------------------------
--
-- tpz.effect.VISITANT
--
-----------------------------------

function onEffectGain(target,effect)
    -- Remove any older dedication effect
    if target:hasStatusEffect(tpz.effect.DEDICATION) then
        target:delStatusEffect(tpz.effect.DEDICATION)
    end

    target:addStatusEffect(tpz.effect.DEDICATION,60,3,0,0,5000000)
    local expEffect = target:getStatusEffect(tpz.effect.DEDICATION)
    local visEffect = target:getStatusEffect(tpz.effect.VISITANT)
    expEffect:setFlag(tpz.effectFlag.ON_ZONE)
    visEffect:setFlag(tpz.effectFlag.ON_ZONE)
end

function onEffectTick(target,effect)
    --[[
    local duration = effect:getDuration()
    if (target:getCharVar("Abyssea_Time") >= 3) then
        target:setCharVar("Abyssea_Time",duration)
    end
    Some messages about remaining time.will need to handled outside of this effect (zone ejection warnings after visitant is gone).
    ]]
end

function onEffectLose(target,effect)
    target:warp()
end
