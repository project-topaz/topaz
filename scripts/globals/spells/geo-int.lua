-----------------------------------------
-- Spell: Geo-Int
-- Enhances Intelligence for party members within area of effect. 
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/geo")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    if caster:getPetID() == 75 then
        return tpz.msg.basic.LUOPAN_ALREADY_PLACED
    elseif not caster:canUseMisc(tpz.zoneMisc.PET) then
        return tpz.msg.basic.CANT_BE_USED_IN_AREA
    else
        return 0
    end
end


function onSpellCast(caster, target, spell)
    local spellCost = caster:getSpellCost(spell:getID())
    tpz.geo.spawnLuopan(caster, target, tpz.effect.GEO_INT_BOOST, tpz.allegiance.PLAYER, spellCost)
end