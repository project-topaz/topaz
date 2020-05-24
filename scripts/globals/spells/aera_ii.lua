-----------------------------------------
-- Spell: Aera II
-- Deals wind damage to enemies within area of effect.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    print("working")
    local spellParams = {}
    spellParams.hasMultipleTargetReduction = true
    spellParams.resistBonus = 1.0
    spellParams.V = 396
    spellParams.V0 = 430
    spellParams.V50 = 600
    spellParams.V100 = 740
    spellParams.V200 = 740
    spellParams.M = 1
    spellParams.M0 = 3.4
    spellParams.M50 = 2.8
    spellParams.M100 = 1.9
    spellParams.M200 = 1.9

    return doElementalNuke(caster, spell, target, spellParams)
end
