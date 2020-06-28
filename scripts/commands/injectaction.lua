---------------------------------------------------------------------------------------------------
-- func: injectaction
-- desc: Injects an action packet with the specified action and animation id.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 5,
    parameters = "iiiii"
}

function onTrigger(caller, entity, actionId, animationId, speceffect, reaction, message)
    local usage = "!injectaction <action ID> <animation ID> {speceffect} {reaction} {message}"

    -- validate actionId
    if (actionId == nil) then
        tpz.commands.error(caller, entity, "You must provide an action ID.", usage)
        return
    end

    -- validate animationId
    if (animationId == nil) then
        tpz.commands.error(caller, entity, "You must provide an animation ID.", usage)
        return
    end

    if (message == nil) then
        message = 185 -- Default message
    end

    -- inject action packet
    entity:injectActionPacket(actionId, animationId, speceffect, reaction, message)
end
