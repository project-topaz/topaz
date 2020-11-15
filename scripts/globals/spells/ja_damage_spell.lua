--------------------------------------------------
---                                            ---
---  Ja Spell (extends Elemental Damage Spell) ---
---                                            ---
--------------------------------------------------
require("scripts/globals/spells/elemental_damage_spell")

tpz.magic.JASpell = tpz.magic.JASpell or tpz.magic.ElementalDamageSpell:create()
tpz.magic.JASpell.__index = tpz.magic.JASpell

function tpz.magic.JASpell:castSpell(spell, caster, target)
    local damage, msg = tpz.magic.ElementalDamageSpell.castSpell(self, spell, caster, target)

    self:addDebuff(target, spell:getElement())

    return damage, msg
end

function tpz.magic.JASpell:addDebuff(target, element)
    local effect = target:getStatusEffect(tpz.effect.CUMULATIVE_MAGIC_BONUS)

    -- If we already have the effect and its a matching element, beef it up
    if effect ~= nil and effect:getSubType() == element then
        effect:setPower(effect:getPower() + 1)
    else
        -- if we got here, we, at minimum, don't have matching element, so delete whats there
        if effect ~= nil then
            target:delStatusEffect(tpz.effect.CUMULATIVE_MAGIC_BONUS)
        end
        -- now, add a fresh cumulative effect (starting over)
        -- TODO: certain blm items extend this duration, but them and their mods are not in
        --       and that is currently outside of the purview of this refactor
        target:addStatusEffectEx(tpz.effect.CUMULATIVE_MAGIC_BONUS, 0, 1, 0, 60, element)
    end
end