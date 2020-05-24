-----------------------------------------
-- Spell: Fira
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
    spellParams.V = 216
    spellParams.V0 = 140
    spellParams.V50 = 360
    spellParams.V100 = 445
    spellParams.V200 = 445
    spellParams.M = 1
    spellParams.M0 = 2.4
    spellParams.M50 = 1.7
    spellParams.M100 = 1
    spellParams.M200 = 1

    return doElementalNuke(caster, spell, target, spellParams)
end
