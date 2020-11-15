-----------------------------------
-- Ability: Blaze of Glory
-- Increases the effects of your next applicable geomancy spell.
-- Consumes half of that luopan's HP. 
-- Obtained: Geomancer Level 60
-- Recast Time: 00:10:00
-- Duration: 00:01:00 
-- Notes: Luopan Potency +50%
-- Blaze of Glory has to be active first before using any Geocolure spell.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player,target,ability)
    if player:hasPet() and player:getPetID() == 75 then
        return tpz.msg.basic.HAS_LUOPON_NO_USE, 0
    end
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.BLAZE_OF_GLORY, 0, 0, 60)
end
