-----------------------------------
-- Magic Shield
-- Blocks magic damage and effects depending on power
--
-- Power Notes:
--  0 - 50%  DMGMAGIC (e.g. Fool's Tonic)
--  1 UNUSED
--  2 -101% UDMGMAGIC (e.g. Spiritual Incense)
--  4 -101% UDMGMAGIC and Immune to Enfeebles (e.g. Fool's Drink, Polar Bulwark)
--  8 UNUSED
-- 16 All Element Specific Absorb 100% (Arcane Stomp)
-- 32 UNUSED
-- 64 All Magic (incl. non-elemental) Absorb 100% (e.g. Mind Wall)
-----------------------------------
require("scripts/globals/status")

function onEffectGain(target, effect)
    if effect:getPower() == 64 then
        target:addMod(tpz.mod.MAGIC_ABSORB, 100)
    elseif effect:getPower() == 16 then
        target:addMod(tpz.mod.FIRE_ABSORB, 100)
        target:addMod(tpz.mod.EARTH_ABSORB, 100)
        target:addMod(tpz.mod.WATER_ABSORB, 100)
        target:addMod(tpz.mod.WIND_ABSORB, 100)
        target:addMod(tpz.mod.ICE_ABSORB, 100)
        target:addMod(tpz.mod.LTNG_ABSORB, 100)
        target:addMod(tpz.mod.LIGHT_ABSORB, 100)
        target:addMod(tpz.mod.DARK_ABSORB, 100)
    elseif effect:getPower() == 4 then
        target:addMod(tpz.mod.UDMGMAGIC, -101)
    elseif effect:getPower() == 2 then
        target:addMod(tpz.mod.UDMGMAGIC, -101)
    else
        target:addMod(tpz.mod.DMGMAGIC, -50)
    end
end

function onEffectLose(target, effect)
    if effect:getPower() == 64 then
        target:delMod(tpz.mod.MAGIC_ABSORB, 100)
    elseif effect:getPower() == 16 then
        target:delMod(tpz.mod.FIRE_ABSORB, 100)
        target:delMod(tpz.mod.EARTH_ABSORB, 100)
        target:delMod(tpz.mod.WATER_ABSORB, 100)
        target:delMod(tpz.mod.WIND_ABSORB, 100)
        target:delMod(tpz.mod.ICE_ABSORB, 100)
        target:delMod(tpz.mod.LTNG_ABSORB, 100)
        target:delMod(tpz.mod.LIGHT_ABSORB, 100)
        target:delMod(tpz.mod.DARK_ABSORB, 100)
    elseif effect:getPower() == 4 then
        target:delMod(tpz.mod.UDMGMAGIC, -101)
    elseif effect:getPower() == 2 then
        target:delMod(tpz.mod.UDMGMAGIC, -101)
    else
        target:delMod(tpz.mod.DMGMAGIC, -50)
    end
end
