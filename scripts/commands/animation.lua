---------------------------------------------------------------------------------------------------
-- func: animation
-- desc: Sets the players current animation.
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function onTrigger(caller, player, animationId)
    local usage = "!animation {animationID}"

    local oldAnimation = player:getAnimation()

    if (animationId == nil) then
        tpz.commands.print(caller, player, string.format("Current player animation: %d", oldAnimation))
        return
    end

    -- validate animationId
    animationId = tonumber(animationId) or tpz.anim[string.upper(animationId)]
    if (animationId == nil or animationId < 0) then
        tpz.commands.error(caller, player, "Invalid animationId.", usage)
        return
    end

    -- set player animation
    player:setAnimation(animationId)
    tpz.commands.print(caller, player, string.format("%s | Old animation: %i | New animation: %i\n", player:getName(), oldAnimation, animationId))
end
