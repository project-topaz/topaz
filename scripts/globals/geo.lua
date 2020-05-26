-----------------------------------
-- Geomancer helpers
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/pets")
-----------------------------------
-- Notes at the bottom of the page.

tpz = tpz or {}
tpz.geo = tpz.geo or {}

--------------------------------------------------------------------
-- Table of model id's for luopans based on element and target type.
--------------------------------------------------------------------
local luopanModel =
{
    [1] = {2858, 2850}, -- Fire
    [2] = {2861, 2853}, -- Earth
    [3] = {2863, 2855}, -- Water
    [4] = {2860, 2852}, -- Wind
    [5] = {2859, 2851}, -- Ice
    [6] = {2862, 2854}, -- Thunder
    [7] = {2864, 2856}, -- Light
    [8] = {2865, 2857}  -- Dark
}

------------------------------------------------
-- Table of offsets for the player bubble effect.
------------------------------------------------
local playerBubbleEffect =
{
    [1] = { 8, 0}, -- Fire
    [2] = {11, 3}, -- Earth
    [3] = {13, 5}, -- Water
    [4] = {10, 2}, -- Wind
    [5] = { 9, 1}, -- Ice
    [6] = {12, 4}, -- Thunder
    [7] = {14, 6}, -- Light
    [8] = {15, 7}  -- Dark
}

----------------------------------------------------------------------------------------
-- Potency data for all GEO and INDI spells based on the effect.
----------------------------------------------------------------------------------------
local potencyData =
{
    [539] = {divisor =  20, minPotency = 1.0, maxPotency = 30.0}, -- GEO_REGEN
    [540] = {divisor =  20, minPotency = 1.0, maxPotency = 30.0}, -- GEO_POISON
    [541] = {divisor = 120, minPotency = 1.0, maxPotency =  6.0}, -- GEO_REFRESH
    [542] = {divisor =  37, minPotency = 1.0, maxPotency = 25.0}, -- GEO_STR_BOOST
    [543] = {divisor =  37, minPotency = 1.0, maxPotency = 25.0}, -- GEO_DEX_BOOST
    [544] = {divisor =  37, minPotency = 1.0, maxPotency = 25.0}, -- GEO_VIT_BOOST
    [545] = {divisor =  37, minPotency = 1.0, maxPotency = 25.0}, -- GEO_AGI_BOOST
    [546] = {divisor =  37, minPotency = 1.0, maxPotency = 25.0}, -- GEO_INT_BOOST
    [547] = {divisor =  37, minPotency = 1.0, maxPotency = 25.0}, -- GEO_MND_BOOST
    [548] = {divisor =  37, minPotency = 1.0, maxPotency = 25.0}, -- GEO_CHR_BOOST
    [549] = {divisor =  30, minPotency = 4.6, maxPotency = 34.7}, -- GEO_ATTACK_BOOST
    [550] = {divisor =  30, minPotency = 9.7, maxPotency = 39.8}, -- GEO_DEFENSE_BOOST
    [551] = {divisor =  75, minPotency = 3.0, maxPotency = 15.0}, -- GEO_MAGIC_ATK_BOOST
    [552] = {divisor =  60, minPotency = 5.0, maxPotency = 20.0}, -- GEO_MAGIC_DEF_BOOST
    [553] = {divisor =  18, minPotency = 1.0, maxPotency = 50.0}, -- GEO_ACCURACY_BOOST
    [554] = {divisor =  14, minPotency = 1.0, maxPotency = 65.0}, -- GEO_EVASION_BOOST
    [555] = {divisor =  18, minPotency = 1.0, maxPotency = 50.0}, -- GEO_MAGIC_ACC_BOOST
    [556] = {divisor =  14, minPotency = 1.0, maxPotency = 65.0}, -- GEO_MAGIC_EVASION_BOOST
    [557] = {divisor =  44, minPotency = 4.6, maxPotency = 25.0}, -- GEO_ATTACK_DOWN
    [558] = {divisor =  74, minPotency = 2.7, maxPotency = 14.8}, -- GEO_DEFENSE_DOWN
    [559] = {divisor =  60, minPotency = 5.0, maxPotency = 20.0}, -- GEO_MAGIC_ATK_DOWN
    [560] = {divisor =  75, minPotency = 3.0, maxPotency = 15.0}, -- GEO_MAGIC_DEF_DOWN
    [561] = {divisor =  14, minPotency = 1.0, maxPotency = 65.0}, -- GEO_ACCURACY_DOWN
    [562] = {divisor =  18, minPotency = 1.0, maxPotency = 50.0}, -- GEO_EVASION_DOWN
    [563] = {divisor =  14, minPotency = 1.0, maxPotency = 65.0}, -- GEO_MAGIC_ACC_DOWN
    [564] = {divisor =  18, minPotency = 1.0, maxPotency = 50.0}, -- GEO_MAGIC_EVASION_DOWN
    [565] = {divisor =  64, minPotency = 0.9, maxPotency = 14.9}, -- GEO_SLOW
    [566] = {divisor =  64, minPotency = 1.0, maxPotency = 15.0}, -- GEO_PARALYSIS
    [567] = {divisor =  56, minPotency = 3.9, maxPotency = 19.9}, -- GEO_WEIGHT
    [580] = {divisor =  30, minPotency = 2.4, maxPotency = 29.9}, -- GEO_HASTE
}

----------------------------------------------------------------------------------------
-- Get the potency for the spell based on a combined geomancy and handbell skill.
----------------------------------------------------------------------------------------
tpz.geo.getPotency = function(player, effect)
    local handbell_skill = player:getSkillLevel(tpz.skill.HANDBELL)
    local geo_skill = player:getSkillLevel(tpz.skill.GEOMANCY)

    if player:getItemSkillType(tpz.slot.RANGED) ~= tpz.skill.HANDBELL then
        handbell_skill = 0
    end
    
    local skillPotency = (handbell_skill + geo_skill)  
    local potency = utils.clamp(math.floor(skillPotency / potencyData[effect].divisor), potencyData[effect].minPotency, potencyData[effect].maxPotency)
    -- Note: need to add bonuses from bells and gear.

    return math.floor(potency)
end

----------------------------------------------------------------------------------------
-- Global function for onSpellCast for all Indi spells.
----------------------------------------------------------------------------------------
tpz.geo.doIndiSpell = function(caster, target, spell, tick_effect, target_type)
    local potency = tpz.geo.getPotency(caster, tick_effect)
    local element = caster:getStatusEffectElement(tick_effect)
    local bubbleEffect = playerBubbleEffect[element][target_type +1]

    target:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, bubbleEffect, 3, 180, tick_effect, potency, target_type, tpz.effectFlag.AURA)
end

----------------------------------------------------------------------------------------
-- Global function to spawn a luopan.
----------------------------------------------------------------------------------------
tpz.geo.spawnLuopan = function(player, target, tick_effect, target_type, spellCost)
    if target_type == tpz.allegiance.MOB and target == nil then
        return
    else
        tpz.pet.spawnPet(player, tpz.pet.id.LUOPAN)
    end

    local element = player:getStatusEffectElement(tick_effect)
    local modelID = luopanModel[element][target_type +1]
    local potency = tpz.geo.getPotency(player, tick_effect)
    local luopan = player:getPet()
    local petID  = luopan:getID()
    local targetPos = target:getPos()
    local luopanMaxHP = luopan:getMaxHP()

    -- Set the luopans pos to the same as the targets pos.
    luopan:setPos(targetPos.x, targetPos.y -10, targetPos.z + 0.2, 0)

    if player:hasStatusEffect(tpz.effect.BLAZE_OF_GLORY) then
        potency = potency *2
    end

    -- Attach effect
    luopan:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, 0, 3, 600, tick_effect, finalPotency, target_type, tpz.effectFlag.AURA)
    
    -- Save the mp cost for use with Full Circle.
    luopan:setLocalVar("MP_COST", spellCost)

    -- Change the luopans appearance to match the effect.
    luopan:setModelId(modelID)

    -- Add HP boost if the player has Bolster effect
    if player:hasStatusEffect(tpz.effect.BOLSTER) then
        luopan:addStatusEffect(tpz.effect.MAX_HP_BOOST, 50, 0, player:getStatusEffect(tpz.effect.BOLSTER):getTimeRemaining() / 1000)
    end

    if player:hasStatusEffect(tpz.effect.BLAZE_OF_GLORY) and not player:hasStatusEffect(tpz.effect.BOLSTER) then
        luopan:setHP(luopanMaxHP/2)
    elseif player:hasStatusEffect(tpz.effect.BLAZE_OF_GLORY) and player:hasStatusEffect(tpz.effect.BOLSTER) then
        luopan:setHP(luopanMaxHP)
    else
        luopan:setHP(luopanMaxHP)
    end

    if player:hasStatusEffect(tpz.effect.BLAZE_OF_GLORY) then
        player:delStatusEffectSilent(tpz.effect.BLAZE_OF_GLORY)
    end
end
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
-- 0 Fire     [Buff]
-- 1 Ice      [Buff]
-- 2 Wind     [Buff]
-- 3 Earth    [Buff]
-- 4 Thunder  [Buff]
-- 5 Water    [Buff]
-- 6 Light    [Buff]
-- 7 Dark     [Buff]
-- 8 Fire     [Debuff]
-- 9 Ice      [Debuff]
-- 10 Wind    [Debuff]
-- 11 Earth   [Debuff]
-- 12 Thunder [Debuff]
-- 13 Water   [Debuff]
-- 14 Light   [Debuff]
-- 15 Dark    [Debuff]
--------------------------------------

-- The direction bonus is determined by where the target is located relative to the caster when the elemental magic spell actually lands on the target.

-- East = A Magic Attack Bonus will be given if the target is located to the East of the casting Geomancer.
-- West = A Magic Burst Bonus will be given if the target is located to the West of the casting Geomancer.
-- North = Magic Critical Hit Chance is increased if the target is located to the North of the casting Geomancer.
-- South = A Magic Accuracy Bonus will be given if the target is located to the South of the casting Geomancer.
--[[
1 = north
2 = north north east
3 = north east
4 = east north east
5 = east
6 = east south east
7 = south east
8 = south south east
9 = south
10 = south south west
11 = south west
12 = west south west
13 = west
14 = west north west
15 = north west
16 = north north west
]]