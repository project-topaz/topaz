-----------------------------------------
-- Spell: Geo-Refresh
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/geo")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    if caster:getPet() ~= nil then
        return tpz.msg.basic.LUOPAN_ALREADY_PLACED
    elseif not caster:canUseMisc(tpz.zoneMisc.PET) then
        return tpz.msg.basic.CANT_BE_USED_IN_AREA
    else
        return 0
    end
end


function onSpellCast(caster, target, spell)
    local geo_skill = caster:getCharSkillLevel(tpz.skill.GEOMANCY)
    local spellCost = 126
    local power = 0
    if geo_skill < 180 then
        power = 1
    elseif geo_skill >= 180 and geo_skill < 360 then
        power = 2
    elseif geo_skill >= 360 and geo_skill < 540 then
        power = 3
    elseif geo_skill >= 540 and geo_skill < 720 then
        power = 4
    elseif geo_skill >= 720 and geo_skill < 900 then
        power = 3
    else
        power = 6
    end

    tpz.geo.spawnLuopan(caster, target, 2856, tpz.effect.REFRESH_II, power, tpz.allegiance.PLAYER, spellCost)
end
