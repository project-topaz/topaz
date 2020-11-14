-----------------------------------
-- Geomancer helpers
-----------------------------------
require("scripts/globals/pets")
require("scripts/globals/status")
-----------------------------------

tpz = tpz or {}
tpz.geo = tpz.geo or {}

tpz.geo.spawnLuopan = function(player, target, spell, tickEffect, tickPower, targetType)

    tpz.pet.spawnPet(player, tpz.pet.id.LUOPAN)
    local luopan = player:getPet()

    local element = spell:getElement()
    local visibleAura = element - 1

    -- Attach effect
    luopan:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, visibleAura, 3, 0, tickRffect, tickPower, targetType, tpz.effectFlag.AURA)

    -- Save the mp cost for use with Full Circle
    luopan:setLocalVar("MP_COST", spell:getMPCost())

    -- Change the luopans appearance to match the effect
    -- TODO: This should be set in core
    local modelOffset = 2850
    if targetType == tpz.auraTarget.ENEMIES then
        modelOffset = 2858
    end
    luopan:setModelId(modelOffset + visibleAura)

    -- Set HP loss over time
    luopan:addMod(tpz.mod.REGEN_DOWN, luopan:getMainLvl() / 4)

    -- Innate Damage Taken -50%
    luopan:addMod(tpz.mod.DMG, -50)
end
