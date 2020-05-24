-----------------------------------------
-- Spell: Indi-Poison
-- Poisons enemies near the caster and gradually reduces their HP. 
-- Note: the player must have some hate on the mob for the effect to take.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/geo")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    if target:hasStatusEffect(tpz.effect.COLURE_ACTIVE) then
    	local effect = target:getStatusEffect(tpz.effect.COLURE_ACTIVE)
		if effect:getSubType() ==  tpz.effect.GEO_POISON then
		    return tpz.msg.basic.EFFECT_ALREADY_ACTIVE
		end
	end
    return 0
end

function onSpellCast(caster, target, spell)
    tpz.geo.doIndiSpell(caster, target, spell, tpz.effect.GEO_POISON, tpz.allegiance.MOB)
    return tpz.effect.COLURE_ACTIVE
end