---------------------------------------------------
-- Sonic Buffet M=Unknown
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0,0
end

function onPetAbility(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local totaldamage = 0
    local damage = AvatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)
    totaldamage = AvatarFinalAdjustments(damage.dmg,pet,skill,target,tpz.attackType.MAGICAL,tpz.damageType.WIND,numhits)
    target:dispelStatusEffect()
    spell:setMsg(tpz.msg.basic.MAGIC_ERASE)
    target:takeDamage(totaldamage, pet, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    target:updateEnmityFromDamage(pet,totaldamage)
    return totaldamage
end
