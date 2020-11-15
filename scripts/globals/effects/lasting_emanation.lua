-----------------------------------
-- Effect: Lasting Emanation
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target,effect)
    if not target:hasStatusEffect(tpz.effect.BOLSTER) then 
        if target:hasStatusEffect(tpz.effect.ECLIPTIC_ATTRITION) then
            target:setMod(tpz.mod.REGEN_DOWN, effect:getPower() +1)
        else
            target:setMod(tpz.mod.REGEN_DOWN, effect:getPower())
        end
    end
end

function onEffectTick(target,effect)
end

function onEffectLose(target,effect) 
    if target:hasStatusEffect(tpz.effect.BOLSTER) then
        target:setMod(tpz.mod.REGEN_DOWN, target:getMainLvl() / 25)
    elseif target:hasStatusEffect(tpz.effect.ECLIPTIC_ATTRITION) and 
        not target:hasStatusEffect(tpz.effect.BOLSTER) then
        target:setMod(tpz.mod.REGEN_DOWN, target:getMainLvl() / 15)
    else
        target:setMod(tpz.mod.REGEN_DOWN, target:getMainLvl() / 4)
    end
end