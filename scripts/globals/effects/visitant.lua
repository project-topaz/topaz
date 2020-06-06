-----------------------------------
--
-- tpz.effect.VISITANT
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/abyssea")
require("scripts/globals/status")

function onEffectGain(target,effect)
    tpz.abyssea.ResetPlayerLights(target)

    if ABYSSEA_BONUSLIGHT_AMOUNT > 0 then
        tpz.abyssea.SetBonusLights(target)
    end
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
    tpz.abyssea.ResetPlayerLights(target)
end
