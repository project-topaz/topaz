-----------------------------------------
-- Spell: Watera II
-- Deals water damage to enemies within area of effect.
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
    spellParams.V = 356
    spellParams.V0 = 390
    spellParams.V50 = 575
    spellParams.V100 = 720
    spellParams.V200 = 720
    spellParams.M = 1
    spellParams.M0 = 3.7
    spellParams.M50 = 2.9
    spellParams.M100 = 1.95
    spellParams.M200 = 1.95

    return doElementalNuke(caster, spell, target, spellParams)
end
