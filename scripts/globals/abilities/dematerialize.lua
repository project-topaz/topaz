-----------------------------------
-- Ability: Dematerialize
-- Enhances the effects of your luopan.
-- Prevents your luopan from receiving damage.
-- Obtained: Geomancer Level 70
-- Recast Time: 00:10:00
-- Duration: 00:01:00
-----------------------------------
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
    local luopan = player:getPet()
    luopan:addStatusEffect(tpz.effect.MAGIC_SHIELD, 1, 0, 60, true)
    luopan:addStatusEffect(tpz.effect.PHYSICAL_SHIELD, 1, 0, 60, true)
    return tpz.effect.DEMATERIALIZE
end
