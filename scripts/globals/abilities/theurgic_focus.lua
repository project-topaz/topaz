-----------------------------------
-- Ability: Theurgic Focus
-- Increases the power of your next applicable elemental magic spell.
-- Casting range and area of effect are reduced by half.
-- Obtained: Geomancer Level 80
-- Recast Time: 00:05:00
-- Duration: 00:01:00 
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    local jobPointBonus = 0 -- Not coded yet! (Theurgic Focus Effect [ranks availible: 20])
    player:addStatusEffect(tpz.effect.THEURGIC_FOCUS, 50 + jobPointBonus, 0, 60)
end
