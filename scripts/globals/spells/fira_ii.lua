-----------------------------------------
-- Spell: Fira II
-- Deals fire damage to enemies within area of effect.
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
    spellParams.V = 450
    spellParams.V0 = 470
    spellParams.V50 = 625
    spellParams.V100 = 760
    spellParams.V200 = 760
    spellParams.M = 1.5
    spellParams.M0 = 3.1
    spellParams.M50 = 2.7
    spellParams.M100 = 1.85
    spellParams.M200 = 1.85

    return doElementalNuke(caster, spell, target, spellParams)
end
