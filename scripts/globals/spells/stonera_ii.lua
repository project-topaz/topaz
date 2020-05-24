-----------------------------------------
-- Spell: Stonera II
-- Deals earth damage to enemies within area of effect.
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
    spellParams.V = 317
    spellParams.V0 = 350
    spellParams.V50 = 550
    spellParams.V100 = 700
    spellParams.V200 = 700
    spellParams.M = 1
    spellParams.M0 = 4
    spellParams.M50 = 3
    spellParams.M100 = 2
    spellParams.M200 = 2

    return doElementalNuke(caster, spell, target, spellParams)
end
