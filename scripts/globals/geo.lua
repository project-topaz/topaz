-----------------------------------
-- Geomancer helpers
-----------------------------------
require("scripts/globals/pets")
require("scripts/globals/status")
-----------------------------------

-----------------------------------------
-- Luopan model types
-- used when setting the effects power
-- sets the effect in auraTick
-----------------------------------------
-- 2850 Fire    [Buff]
-- 2851 Ice     [Buff]
-- 2852 Wind    [Buff]
-- 2853 Earth   [Buff]
-- 2854 Thunder [Buff]
-- 2855 Water   [Buff]
-- 2856 Light   [Buff]
-- 2857 Dark    [Buff]
-- 2858 Fire    [Debuff]
-- 2859 Ice     [Debuff]
-- 2860 Wind    [Debuff]
-- 2861 Earth   [Debuff]
-- 2862 Thunder [Debuff]
-- 2863 Water   [Debuff]
-- 2864 Light   [Debuff]
-- 2865 Dark    [Debuff]
------------------------------------------

------------------------------------------
-- Player bubble effect
-- used when setting the effects power
-- changes the effect in CCharUpdatePacket
-- base effect is 0x50 and the below
-- numbers add to that number.
------------------------------------------
-- 0 Fire    [Buff]
-- 1 Ice     [Buff]
-- 2 Wind    [Buff]
-- 3 Earth   [Buff]
-- 4 Thunder [Buff]
-- 5 Water   [Buff]
-- 6 Light   [Buff]
-- 7 Dark    [Buff]
-- 8 Fire    [Debuff]
-- 9 Ice     [Debuff]
-- 10 Wind    [Debuff]
-- 11 Earth   [Debuff]
-- 12 Thunder [Debuff]
-- 13 Water   [Debuff]
-- 14 Light   [Debuff]
-- 15 Dark    [Debuff]
--------------------------------------

tpz = tpz or {}
tpz.geo = tpz.geo or {}

tpz.geo.spawnLuopan = function(player, target, aura_effect, tick_effect, tick_power, target_type, spell_cost)
    
    tpz.pet.spawnPet(player, tpz.pet.id.LUOPAN)

    local modelID = aura_effect
    local luopan = player:getPet()
    local petID  = luopan:getID()
    
    -- Attach effect
    luopan:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, 0, 3, 0, tick_effect, tick_power, target_type, tpz.effectFlag.AURA)
    -- Save the mp cost for use with Full Circle.
    luopan:setLocalVar("MP_COST", spell_cost)
    -- Change the luopans appearance to match the effect.
    luopan:setModelId(modelID)
    -- Set HP loss over time.
    luopan:addMod(tpz.mod.REGEN_DOWN, 24)
end
