-----------------------------------------------------------------
---                                                           ---
--- Elemental Skill Resist Calculator (extends Magic Resist)  ---
---                                                           ---
--- We need a separate one for damage since damage is         ---
--- generally all INT based, but enfeebles could be INT or    ---
--- MND.                                                      ---
-----------------------------------------------------------------
require("scripts/globals/calculators/magic_resist")

tpz.calculators.ElementalSkillResist = tpz.calculators.ElementalSkillResist or tpz.calculators.MagicResistCalc:create()
tpz.calculators.ElementalSkillResist.__index = tpz.calculators.ElementalSkillResist

function tpz.calculators.ElementalSkillResist:create(args)
    local object = tpz.calculators.MagicResistCalc:create(args)
    setmetatable(object, self)

    return object
end

function tpz.calculators.ElementalSkillResist:getCasterMagicAcc(caster, target, element)
    -- https://www.bg-wiki.com/bg/Magic_Accuracy
    local mAcc = caster:getMod(tpz.mod.MACC)                     +       -- macc from general macc items
                 caster:getILvlMacc()                            +       -- macc from iLvl
                 caster:getSkillLevel(tpz.skill.ELEMENTAL_MAGIC) +       -- macc from skill
                 caster:getMod(tpz.element.maps.to_macc[element]) -- macc from FIREACC, etc, ie Elemental Staves

    -- Elemental magic skill is all dINT based
    mAcc = mAcc + self:getMAccFromDStat(caster:getMod(tpz.mod.INT), target:getMod(tpz.mod.INT))

    return mAcc
end


function tpz.calculators.ElementalSkillResist:getAccFromMerits(caster, element)
    local merit_mAcc = tpz.calculators.MagicResistCalc.getAccFromMerits(self, caster, element)

    -- Deal with Black Mage Elemental Magic Accuracy Merits
    --- https://www.bg-wiki.com/bg/Category:Elemental_Magic#Merit_Point_Augment
    merit_mAcc = merit_mAcc + caster:getMerit(tpz.merit.ELEMENTAL_MAGIC_ACCURACY)

    return merit_mAcc
end