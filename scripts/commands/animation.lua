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

function onTrigger(caller, entity, animationId)
    local usage = "!animation {animationID}"

    local oldAnimation = entity:getAnimation()

    if (animationId == nil) then
        tpz.commands.print(caller, entity, string.format("Current player animation: %d", oldAnimation))
        return
    end

    -- validate animationId
    animationId = tonumber(animationId) or tpz.anim[string.upper(animationId)]
    if (animationId == nil or animationId < 0) then
        tpz.commands.error(caller, entity, "Invalid animationId.", usage)
        return
    end

    -- set player animation
    entity:setAnimation(animationId)
    tpz.commands.print(caller, entity, string.format("%s | Old animation: %i | New animation: %i\n", entity:getName(), oldAnimation, animationId))
end
