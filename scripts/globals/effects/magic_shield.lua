-----------------------------------
-- Magic Shield
-- Blocks magic damage and effects depending on power
--
-- Power Notes:
--  0 - 50%  DMGMAGIC (e.g. Fool's Tonic)
--  2 -100% UDMGMAGIC (e.g. Spiritual Incense, Fool's Drink, Polar Bulwark)
--  6 All Element Specific Absorb 100% (Arcane Stomp)
--  8 All Magic (incl. non-elemental) Absorb 100% (e.g. Mind Wall)
--
-- subPower Notes:
--  0 Standard Magic Shield (adds magic immunity)
--  1 Fake Magic Shield (does not resist non-damage spells)
-----------------------------------
require("scripts/globals/status")

function onEffectGain(target, effect)
    local power = effect:getPower()
    if power == 8 then
        target:addMod(tpz.mod.MAGIC_ABSORB, 100)
    elseif power == 6 then
        target:addMod(tpz.mod.FIRE_ABSORB, 100)
        target:addMod(tpz.mod.EARTH_ABSORB, 100)
        target:addMod(tpz.mod.WATER_ABSORB, 100)
        target:addMod(tpz.mod.WIND_ABSORB, 100)
        target:addMod(tpz.mod.ICE_ABSORB, 100)
        target:addMod(tpz.mod.LTNG_ABSORB, 100)
        target:addMod(tpz.mod.LIGHT_ABSORB, 100)
        target:addMod(tpz.mod.DARK_ABSORB, 100)
    elseif power == 2 then
        target:addMod(tpz.mod.UDMGMAGIC, -100)
    else
        target:addMod(tpz.mod.DMGMAGIC, -50)
    end
end

function onEffectLose(target, effect)
    local power = effect:getPower()
    if power == 8 then
        target:delMod(tpz.mod.MAGIC_ABSORB, 100)
    elseif power == 6 then
        target:delMod(tpz.mod.FIRE_ABSORB, 100)
        target:delMod(tpz.mod.EARTH_ABSORB, 100)
        target:delMod(tpz.mod.WATER_ABSORB, 100)
        target:delMod(tpz.mod.WIND_ABSORB, 100)
        target:delMod(tpz.mod.ICE_ABSORB, 100)
        target:delMod(tpz.mod.LTNG_ABSORB, 100)
        target:delMod(tpz.mod.LIGHT_ABSORB, 100)
        target:delMod(tpz.mod.DARK_ABSORB, 100)
    elseif power == 2 then
        target:delMod(tpz.mod.UDMGMAGIC, -100)
    else
        target:delMod(tpz.mod.DMGMAGIC, -50)
    end
end
