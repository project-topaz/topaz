-----------------------------------------
-- Spell: Stonera
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
    spellParams.V = 128
    spellParams.V0 = 150
    spellParams.V50 = 300
    spellParams.V100 = 400
    spellParams.V200 = 400
    spellParams.M = 1
    spellParams.M0 = 3
    spellParams.M50 = 2
    spellParams.M100 = 1
    spellParams.M200 = 1

    return doElementalNuke(caster, spell, target, spellParams)
end
