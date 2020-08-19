---------------------
---               ---
--- Spell Factory ---
---               ---
---------------------
require("scripts/globals/calculators/elemental_skill_resist")
require("scripts/globals/calculators/elemental_skill_damage")
require("scripts/globals/spells/elemental_damage_spell")

tpz = tpz or {}
tpz.factories = tpz.factories or {}

local basicEleResistCalculator = tpz.calculators.ElementalSkillResist:create()
local basicEleDamageCalculator = tpz.calculators.ElementalSkillDamage:create{resistCalculator = basicEleResistCalculator}

function tpz.factories.basicEleNuke(spell_params)
    return tpz.magic.ElementalDamageSpell:create(basicEleDamageCalculator, spell_params)
end