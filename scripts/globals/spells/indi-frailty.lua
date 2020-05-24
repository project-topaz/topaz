-----------------------------------------
-- Spell: Indi-Frailty
-- Reduces defense of enemies near the caster.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/geo")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    if target:hasStatusEffect(tpz.effect.COLURE_ACTIVE) then
        local effect = target:getStatusEffect(tpz.effect.COLURE_ACTIVE)
        if effect:getSubType() ==  tpz.effect.GEO_DEFENSE_DOWN then
            return tpz.msg.basic.EFFECT_ALREADY_ACTIVE
        end
    end
    return 0
end

function onSpellCast(caster, target, spell)
    tpz.geo.doIndiSpell(caster, target, spell, tpz.effect.GEO_DEFENSE_DOWN, tpz.allegiance.MOB)
    return tpz.effect.COLURE_ACTIVE
end