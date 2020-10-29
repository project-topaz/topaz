-----------------------------------
-- Physical Shield
-- Blocks physical damage and effects depending on Power
--
-- Power Notes:
--  0 - 50%  DMGPHYS (e.g. Fanatics Tonic)
--  1 UNUSED
--  2 -100% UDMGPHYS (e.g. Carnal Incense, doesn't block WS/TP Moves)
--  4 -100% UDMGPHYS (e.g. Pyric Bulwark, Blocks Physical TP/WS, but not Magical)
--  8 UNUSED
-- 16 -100% UDMGPHYS (e.g. Fanatics Drink, Blocks TP Moves including Magical)
-- 32 UNUSED
-- 64 100% PHYS_ABSORB (e.g. Transmogrification)
-----------------------------------
require("scripts/globals/status")

function onEffectGain(target, effect)
    local power = effect:getPower()
    if power == 64 then
        target:addMod(tpz.mod.PHYS_ABSORB, 100)
    elseif power == 16 then
        target:addMod(tpz.mod.UDMGPHYS, -100)
        --TODO Create MOD and logic to block TP Moves Both Phys and Magical
    elseif power == 4 then
        target:addMod(tpz.mod.UDMGPHYS, -100)
    elseif power == 2 then
        target:addMod(tpz.mod.UDMGPHYS, -100)
        --TODO Create MOD and logic to not negate Physical WS/TP
    else
        target:addMod(tpz.mod.DMGPHYS, -50)
    end
end

function onEffectLose(target, effect)
    local power = effect:getPower()
    if power == 64 then
        target:delMod(tpz.mod.PHYS_ABSORB, 100)
    elseif power == 16 then
        target:delMod(tpz.mod.UDMGPHYS, -100)
        --TODO Create MOD and logic to block TP Moves Both Phys and Magical
    elseif power == 4 then
        target:delMod(tpz.mod.UDMGPHYS, -100)
    elseif power == 2 then
        target:delMod(tpz.mod.UDMGPHYS, -100)
        --TODO Create MOD and logic to not negate Physical WS/TP
    else
        target:delMod(tpz.mod.DMGPHYS, -50)
    end
end
