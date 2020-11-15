-----------------------------------
-- Physical Shield
-- Blocks physical damage and effects depending on Power
--
-- Power Notes:
--  0 - 50%  DMGPHYS (e.g. Fanatics Tonic)
--  2 -100% UDMGPHYS (e.g. Carnal Incense, Pyric Bulwark)
--  3 -100% UDMGPHYS (e.g. Fanatics Drink)
--  8 100% PHYS_ABSORB (e.g. Transmogrification)
--
-- subPower Notes: --TODO plumb in logic for special use cases.
--  0 - DMG Reduction applies to Physical Damage and Physical WS/TP Moves
--  1 - DMG Reduction applies to Physical Damage, Physical WS/TP Moves, and certain Magical TP Moves
--  2 - DMG Reduction applies to Physical Damage (but not WS/TP Moves, specific to Carnal Incense)
-----------------------------------
require("scripts/globals/status")

function onEffectGain(target, effect)
    local power = effect:getPower()
    if power == 8 then
        target:addMod(tpz.mod.PHYS_ABSORB, 100)
    elseif power == 2 or power == 3 then
        target:addMod(tpz.mod.UDMGPHYS, -100)
    else
        target:addMod(tpz.mod.DMGPHYS, -50)
    end
end

function onEffectLose(target, effect)
    local power = effect:getPower()
    if power == 8 then
        target:delMod(tpz.mod.PHYS_ABSORB, 100)
    elseif power == 2 or power == 3 then
        target:delMod(tpz.mod.UDMGPHYS, -100)
    else
        target:delMod(tpz.mod.DMGPHYS, -50)
    end
end
