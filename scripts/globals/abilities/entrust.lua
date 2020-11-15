-----------------------------------
-- Ability: Entrust
-- Causes the next indicolure spell cast to be able to target a party member. 
-- Obtained: Geomancer Level 75
-- Recast Time: 00:10:00
-- Duration: 00:00:30
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.ENTRUST, 1, 0, 60)
    return tpz.effect.ENTRUST
end
