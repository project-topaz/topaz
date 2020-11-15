-----------------------------------
-- Ability: Life Cycle
-- Distributes one fourth of your HP to your luopan.
-- Obtained: Geomancer Level 50
-- Recast Time: 10 minutes 
-- Grants your luopan 25% of your current HP.
-- The HP lost is not affected by gear or job points.
-- You also subsequently cannot kill yourself using this JA.
-- The increase in Life Cycle potency from Job points is applied in the same set as equipment bonuses.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player,target,ability)
    if player:getHP() <= 2 then
        return tpz.msg.basic.UNABLE_TO_USE_JA
    end
    if not player:hasPet() or not player:getPetID() == 75 then
        return tpz.msg.basic.REQUIRE_LUOPAN, 0
    end
    return 0,0
end

function onUseAbility(player,target,ability)
    local luopan       = player:getPet()
    local luopanMaxHP  = luopan:getMaxHP()
    local hp_remaining = player:getHP()
    local hpAmount     = 0.25 * hp_remaining
    local hp_transfer  = math.floor(utils.clamp(hpAmount, 0, luopanMaxHP - luopan:getHP()))
    
    luopan:restoreHP(hp_transfer)
    player:delHP(hp_transfer)
    return hp_transfer
end