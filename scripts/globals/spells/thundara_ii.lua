-----------------------------------------
-- Spell: Thundara II
-- Deals lightning damage to enemies within area of effect.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local spellParams = {}
    spellParams.hasMultipleTargetReduction = true
    spellParams.resistBonus = 1.0
    spellParams.V = 544
    spellParams.V0 = 550
    spellParams.V50 = 675
    spellParams.V100 = 800
    spellParams.V200 = 800
    spellParams.M = 1.5
    spellParams.M0 = 2.5
    spellParams.M50 = 2.5
    spellParams.M100 = 1.75
    spellParams.M200 = 1.75

    return doElementalNuke(caster, spell, target, spellParams)
end
