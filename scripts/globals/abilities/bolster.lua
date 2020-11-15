-----------------------------------
-- Ability: Bolster
-- Enhances the effects of your geomancy spells. 
-- Doubles the potency of Geomancy spells while Bolster is active.
-- Obtained: Geomancer Level 1
-- Recast Time: 01:00:00
-- Duration: 00:03:00 
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.BOLSTER,0,0,240)
end
