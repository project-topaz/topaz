-----------------------------------
-- Ability: Widened Compass
-- Increases the area of effect for geomancy spells.
-- Obtained: Geomancer Level 96
-- Recast Time: 1:00:00
-- Duration: 0:60
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    target:addStatusEffect(tpz.effect.WIDENED_COMPASS,0,0,60,0,0)
    return tpz.effect.WIDENED_COMPASS
end
