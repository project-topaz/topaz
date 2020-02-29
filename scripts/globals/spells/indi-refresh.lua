-----------------------------------------
-- Spell: Indi-Refresh
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
	if caster:hasStatusEffect(tpz.effect.COLURE_ACTIVE) then
    	local effect = caster:getStatusEffect(tpz.effect.COLURE_ACTIVE)
		if effect:getSubType() ==  tpz.effect.REFRESH_II then
		    return tpz.msg.basic.EFFECT_ALREADY_ACTIVE
		end
	end
	return 0
end


function onSpellCast(caster, target, spell)
	local geo_skill = caster:getCharSkillLevel(tpz.skill.GEOMANCY)
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

    caster:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, 6, 3, 180, tpz.effect.REFRESH_II, power, tpz.allegiance.PLAYER, tpz.effectFlag.AURA)
    return tpz.effect.COLURE_ACTIVE
end
