----------------------------------------------------------
---                                                    ---
--- AM2 Damage Calculator (extends Elemental Damage )  ---
---                                                    ---
----------------------------------------------------------
require("scripts/globals/calculators/elemental_skill_damage")

tpz.calculators.AM2Damage = tpz.calculators.AM2Damage or tpz.calculators.ElementalSkillDamage:create()
tpz.calculators.AM2Damage.__index = tpz.calculators.AM2Damage

function tpz.calculators.AM2Damage:getMagicBurstBonusMod(caster)
    return tpz.calculators.MagicDamageCalc.getMagicBurstBonusMod(self, caster) + caster:getMerit(tpz.merit.ANCIENT_MAGIC_BURST_DMG)
end

function tpz.calculators.AM2Damage:getMAB(caster)
    return tpz.calculators.MagicDamageCalc.getMAB(self, caster) + caster:getMerit(tpz.merit.ANCIENT_MAGIC_ATK_BONUS)
end