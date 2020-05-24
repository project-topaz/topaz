-----------------------------------------
-- Spell: Blizzara II
-- Deals ice damage to enemies within area of effect.
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
    spellParams.V = 496
    spellParams.V0 = 510
    spellParams.V50 = 650
    spellParams.V100 = 780
    spellParams.V200 = 780
    spellParams.M = 1.5
    spellParams.M0 = 2.8
    spellParams.M50 = 2.6
    spellParams.M100 = 1.8
    spellParams.M200 = 1.8

    return doElementalNuke(caster, spell, target, spellParams)
end
