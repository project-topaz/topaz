-----------------------------------
-- Ability: Full Circle
-- Causes your luopan to vanish.
-- Obtained: Geomancer Level 5
-- Recast Time: 10 seconds
-- Refunds some of the MP consumed by the Geocolure spell that created the luopan.
-- Amount of MP restored varies depending on remaining Luopan HP.
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
    local luopan        = player:getPet()
    local hpp_remaining = luopan:getHPP()
    local mp_cost       = luopan:getLocalVar("MP_COST")
    local mp_returned   = (0.5 * mp_cost) * hpp_remaining / 100
    local hp_returned   = 0
    local crMerit       = player:getMerit(tpz.merit.CURATIVE_RECANTATION)

    if crMerit > 0 then
       hp_returned = mp_returned + ((mp_returned *0.5) *crMerit)
       player:restoreHP(hp_returned)
    end
    player:restoreMP(mp_returned)
    target:despawnPet()
end