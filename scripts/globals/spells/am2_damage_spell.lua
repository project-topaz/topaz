----------------------------------------
---                                  ---
--- Ancient Magic II Spell           ---
--- (extends Elemental Damage Spell) ---
---                                  ---
----------------------------------------
require("scripts/globals/spells/elemental_damage_spell")
require("scripts/globals/status")

tpz.magic.AM2DamageSpell = tpz.magic.AM2DamageSpell or tpz.magic.ElementalDamageSpell:create()
tpz.magic.AM2DamageSpell.__index = tpz.magic.AM2DamageSpell

function tpz.magic.AM2DamageSpell:castSpell(spell, caster, target)
    local damage, msg = tpz.magic.ElementalDamageSpell.castSpell(self, spell, caster, target)

    self:addDebuff(target, spell:getElement())

    return damage, msg
end

function tpz.magic.AM2DamageSpell:addDebuff(target, element)
    target:addStatusEffectEx(tpz.effect.NINJUTSU_ELE_DEBUFF, 0, 30, 0, 10, 0, tpz.element.maps.to_descendant_element[element], 0 )
end
