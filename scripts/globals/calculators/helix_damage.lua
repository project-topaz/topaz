------------------------------------------------------------
---                                                      ---
--- Helix Damage Calculator (extends Elemental Damage )  ---
---                                                      ---
------------------------------------------------------------
require("scripts/globals/calculators/elemental_skill_damage")

tpz.calculators.HelixDamage = tpz.calculators.HelixDamage or tpz.calculators.ElementalSkillDamage:create()
tpz.calculators.HelixDamage.__index = tpz.calculators.HelixDamage

function tpz.calculators.HelixDamage:calculateDamage(caster, target, spell_params, element, num_target)
    -- Helix have custom dINT Adjustment, but don't pass in constructor or you eliminate the chance to pass in a custom table
    spell_params.dINT_adjustment = {0, 77, 234}

    local damage, msg = tpz.calculators.ElementalSkillDamage.calculateDamage(self, caster, target, spell_params, element, num_target)

    -- https://www.bg-wiki.com/bg/Category:Helix
    damage = math.floor(damage * (1.00 + (caster:getMerit(tpz.merit.HELIX_MAGIC_ACC_ATT) * 2) / 100))

    return damage, msg
end

function tpz.calculators.HelixDamage:calculateVMIndex(dStat)
    local VMIndex = 1

    if dStat <= 77 then
        VMIndex = 1
    elseif 78 <= dStat and dStat <= 234 then
        VMIndex = 2
    elseif 235 <= dStat then
        VMIndex = 3
    end

    return VMIndex
end

function tpz.calculators.HelixDamage:shouldForceDayWeatherProc(caster, element)
    return true
end

-- TODO: https://www.bg-wiki.com/bg/Category:Helix
--       What does this mean? ...
--       "enemies are more susceptible to the full power of a Helix if the Helix is of the element they are weak against"
--       Need research, maybe they do bonus damage to SDT?
-- TODO: testing (test all the AM2 and Helix paths, ie their merits)