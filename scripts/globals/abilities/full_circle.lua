-----------------------------------
-- Ability: Full Circle
-- Causes your luopan to vanish.
-- Obtained: Geomancer Level 5
-- Recast Time: 10 seconds
-- Refunds some of the MP consumed by the Geocolure spell that created the luopan.
-- Amount of MP restored varies depending on remaining Luopan HP.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player,target,ability)
    if not player:hasPet() then
        return tpz.msg.basic.REQUIRE_LUOPAN, 0
    elseif not player:getPetID() or not player:getPetID() == 73 then
        return tpz.msg.basic.NO_EFFECT_ON_PET, 0
    else
        return 0,0
    end
end

function onUseAbility(player,target,ability)
    local luopan        = player:getPet()
    local hpp_remaining = luopan:getHPP()
    local mp_cost       = luopan:getLocalVar("MP_COST")
    local mp_returned   = (0.5) * (mp_cost) * (hpp_remaining) / 100

    player:addMP(mp_returned)
    target:despawnPet()
end