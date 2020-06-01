-----------------------------------------
-- Spell: Watera
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
    spellParams.V = 153
    spellParams.V0 = 180
    spellParams.V50 = 320
    spellParams.V100 = 415
    spellParams.V200 = 415
    spellParams.M = 1
    spellParams.M0 = 2.8
    spellParams.M50 = 1.9
    spellParams.M100 = 1
    spellParams.M200 = 1

    return doElementalNuke(caster, spell, target, spellParams)
end
