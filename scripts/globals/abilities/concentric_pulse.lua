-----------------------------------
-- Ability: Concentric Pulse
-- Causes your luopan to vanish and deals damage to enemies within area of effect.
-- Obtained: Geomancer level 90
-- Recast Time: 5 minutes
-- Duration: N/A
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------

function onAbilityCheck(player,target,ability)
    if not player:hasPet() or not player:getPetID() == 75 then
        return tpz.msg.basic.REQUIRE_LUOPAN, 0
    elseif not target then
        return tpz.msg.basic.CANNOT_PERFORM
    end
    return 0,0
end

function onUseAbility(player,target,ability)
    local pet = player:getPet()
    pet:useMobAbility(3045, target)
end
