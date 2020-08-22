-----------------------------------------------------------------
---                                                           ---
--- Helix Resist Calculator (extends Elemental Skill Resist)  ---
---                                                           ---
-----------------------------------------------------------------
require("scripts/globals/calculators/elemental_skill_resist")

tpz.calculators.HelixResist = tpz.calculators.HelixResist or tpz.calculators.ElementalSkillResist:create()
tpz.calculators.HelixResist.__index = tpz.calculators.HelixResist

function tpz.calculators.HelixResist:getAccFromMerits(caster, element)
    local spell_mAcc = tpz.calculators.ElementalSkillResist.getAccFromMerits(self, caster, element)

    -- https://www.bg-wiki.com/bg/Scholar#Merits
    spell_mAcc = spell_mAcc + caster:getMerit(tpz.merit.HELIX_MAGIC_ACC_ATT) * 3

    return spell_mAcc
end