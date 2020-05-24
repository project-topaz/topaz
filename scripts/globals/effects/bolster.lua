-----------------------------------
--
--   Bolster
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target,effect)
    local luopan = target:getPet()
    if target:hasPet() and target:getPetID() == 75 then
        target:setMod(tpz.mod.REGEN_DOWN, luopan:getMainLvl() / 25)
    end
end

function onEffectTick(target,effect)
end

function onEffectLose(target,effect)
    local luopan = target:getPet() 
    if target:hasPet() and traget:getPetID() == 75 then
        if luopan:hasStatusEffect(tpz.effect.MAX_HP_BOOST) then
            luopan:delStatusEffect(tpz.effect.MAX_HP_BOOST)
        end
        if target:hasStatusEffect(tpz.effect.ECLIPTIC_ATTRITION) and 
            target:hasStatusEffect(tpz.effect.LASTING_EMANATION) then
            target:setMod(tpz.mod.REGEN_DOWN, luopan:getMainLvl() / 4.5)
        elseif target:hasStatusEffect(tpz.effect.ECLIPTIC_ATTRITION) and not 
            target:hasStatusEffect(tpz.effect.LASTING_EMANATION) then
            target:setMod(tpz.mod.REGEN_DOWN, luopan:getMainLvl() / 15)
        elseif target:hasStatusEffect(tpz.effect.LASTING_EMANATION) and not 
            target:hasStatusEffect(tpz.effect.ECLIPTIC_ATTRITION) then
            target:setMod(tpz.mod.REGEN_DOWN, luopan:getMainLvl() / 16)
        else
            target:setMod(tpz.mod.REGEN_DOWN, luopan:getMainLvl() / 4)
        end
    end
end







