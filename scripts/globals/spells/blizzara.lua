-----------------------------------------
-- Spell: Blizzara
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
    spellParams.V = 247
    spellParams.V0 = 270
    spellParams.V50 = 380
    spellParams.V100 = 460
    spellParams.V200 = 460
    spellParams.M = 1
    spellParams.M0 = 2.2
    spellParams.M50 = 1.6
    spellParams.M100 = 1
    spellParams.M200 = 1

    return doElementalNuke(caster, spell, target, spellParams)
end
