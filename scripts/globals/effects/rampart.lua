-----------------------------------
--     tpz.effect.RAMPART
-----------------------------------
require("scripts/globals/status")

function onEffectGain(target, effect)
    local power = -1 * effect:getPower()
    if target:isPC() and target:hasTrait(77) then -- Iron Will
        target:addMod(tpz.mod.SPELLINTERRUPT, target:getMerit(tpz.merit.IRON_WILL))
    end
    target:addMod(tpz.mod.UDMGPHYS, power)
    target:addMod(tpz.mod.UDMGBREATH, power)
    target:addMod(tpz.mod.UDMGMAGIC, power)
    target:addMod(tpz.mod.UDMGRANGE, power)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local power = -1 * effect:getPower()
    if target:isPC() and target:hasTrait(77) then -- Iron Will
        target:delMod(tpz.mod.SPELLINTERRUPT, target:getMerit(tpz.merit.IRON_WILL))
    end
    target:delMod(tpz.mod.UDMGPHYS, power)
    target:delMod(tpz.mod.UDMGBREATH, power)
    target:delMod(tpz.mod.UDMGMAGIC, power)
    target:delMod(tpz.mod.UDMGRANGE, power)
end
