-----------------------------------
-- Ability: Mending Halation
-- Causes your luopan to vanish and restores HP of party members within area of effect.
-- Obtained: Geomancer Level 75
-- Recast Time: 00:05:00
-- Duration: N/A
-- Note: Heals for a fixed amount based on Luopan Level:
-- HP Healed = (7*Luopan Level×(1+0.05×(Merit Level-1)) + 1)×Relic Pants Bonus
-- Luopan Level is capped at 99.
-- This is a light-based cure, so it can suffer Darkness day/weather penalties.
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
    pet:useMobAbility(3051, target)
end
