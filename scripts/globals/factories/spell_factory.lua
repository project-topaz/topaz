---------------------
---               ---
--- Spell Factory ---
---               ---
---------------------
require("scripts/globals/calculators/elemental_skill_resist")
require("scripts/globals/calculators/elemental_skill_damage")
require("scripts/globals/calculators/am2_damage")
require("scripts/globals/spells/elemental_damage_spell")
require("scripts/globals/spells/am2_damage_spell")


tpz = tpz or {}
tpz.factories = tpz.factories or {}

local basicEleResistCalculator = tpz.calculators.ElementalSkillResist:create()
local basicEleDamageCalculator = tpz.calculators.ElementalSkillDamage:create{resistCalculator = basicEleResistCalculator}

function tpz.factories.basicEleNuke(spell_params)
    return tpz.magic.ElementalDamageSpell:create(basicEleDamageCalculator, spell_params)
end

local am2EleDamageCalculator = tpz.calculators.AM2Damage:create{resistCalculator = basicEleResistCalculator}

function tpz.factories.am2Nuke(spell_params)
    return tpz.magic.AM2DamageSpell:create(am2EleDamageCalculator, spell_params)
end