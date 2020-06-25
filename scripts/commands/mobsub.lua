---------------------------------------------------------------------------------------------------
-- func: mobsub
-- desc: Changes the sub-animation of the given mob. (For testing purposes.)
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "ss"
}

function onTrigger(caller, player, arg1, arg2)
    local usage = "!mobsub {mob ID} <animation ID>"
    
    local target
    local animationId

    if (arg2 ~= nil) then
        target = arg1
        animationId = arg2
    elseif (arg1 ~= nil) then
        animationId = arg1
    else
        tpz.commands.error(caller, player, "You must provide an animation ID.", usage)
        return
    end

    local targ = tpz.commands.getTargetMob(caller, player, target)

    -- validate animationId
    animationId = tonumber(animationId) or tpz.anim[string.upper(animationId)]
    if (animationId == nil or animationId < 0) then
        tpz.commands.error(caller, player, "Invalid animation ID.", usage)
        return
    end

    -- set animation sub
    targ:AnimationSub(animationId)
end
