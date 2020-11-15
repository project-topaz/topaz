-----------------------------------
-- Ability: Radial Arcana
-- Causes your luopan to vanish and restores MP of party members within area of effect.
-- Obtained: Geomancer Level 75
-- Recast Time: 00:05:00
-- Duration: N/A
-- Note: Heals for a fixed amount based on Luopan Level:
-- MP Healed = (3*Luopan Level×[1+(0.03×(Merit Level-1))] + 1)×1.X Where X = Bagua Sandals/+1 
-- bonus such that with 1/5 merits, X = 05; and 5/5 merits, X = 25. (05/merit)
-- Luopan Level is capped at 99.
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player,target,ability)
    if not player:hasPet() or not player:getPetID() == 75 then
        return tpz.msg.basic.REQUIRE_LUOPAN, 0
    end
    return 0,0
end

function onUseAbility(player,target,ability)
    local pet = player:getPet()
    pet:useMobAbility(3052, target)
end
