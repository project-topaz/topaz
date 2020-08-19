-------------------------------------------------
---                                           ---
--- Elemental Spell (extends Spell interface) ---
---                                           ---
-------------------------------------------------

require("scripts/globals/interfaces/spell")
require("scripts/globals/data/element")

tpz = tpz or {}
tpz.magic = tpz.magic or {}

tpz.magic.ElementalDamageSpell = tpz.magic.ElementalDamageSpell or tpz.interfaces.Spell:create()
tpz.magic.ElementalDamageSpell.__index = tpz.magic.ElementalDamageSpell

function tpz.magic.ElementalDamageSpell:create(damage_calculator, params)
    local spell = tpz.interfaces.Spell:create{
        damageCalculator = damage_calculator,
        spell_params     = params,
    }

    setmetatable(spell, self)

    return spell
end

function tpz.magic.ElementalDamageSpell:castSpell(spell, caster, target)
    local element = spell:getElement()

    local damage = self.damageCalculator:calculateDamage(caster, target, self.spell_params, element, spell:getTotalTargets())

    -- Adjust the Damage for Phalanx
    damage = self:handlePhalanx(target, damage)

    -- Adjust the Damage for Stoneskin
    damage = self:handleStoneskin(target, damage)

    -- Deal the Damage
    self:dealDamage(spell, caster, target, damage, element)

    -- Add the Nuke Wall
    self:addNukeWall(target, element)

    return damage, 0
end

function tpz.magic.ElementalDamageSpell:handlePhalanx(target, damage)
    local phalanx_reduced_damage = damage - target:getMod(tpz.mod.PHALANX)

    return utils.clamp(phalanx_reduced_damage, 0, 99999)
end

function tpz.magic.ElementalDamageSpell:handleStoneskin(target, damage)
    local stoneskin_reduced_damage = utils.stoneskin(target, damage)

    return utils.clamp(stoneskin_reduced_damage, 0, 99999)
end

function tpz.magic.ElementalDamageSpell:dealDamage(spell, caster, target, damage, element)
    target:takeSpellDamage(caster, spell, damage, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL + element)
    target:updateEnmityFromDamage(caster, damage)

    if target:getObjType() ~= tpz.objType.PC then
        target:addTP(100)
    end
end

function tpz.magic.ElementalDamageSpell:addNukeWall(target, element)
    local effect_id = tpz.element.maps.to_nukewall_effect[element]

    if target:isNM() and target:hasStatusEffect(effect_id) == false then
        target:addStatusEffectEx(effect_id, 0, 1, 0, 5)
    end
end
