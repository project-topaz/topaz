---------------------------------------------------------------------------------------------------
-- func: mobsub
-- desc: Changes the sub-animation of the given mob. (For testing purposes.)
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "sn"
}

function onTrigger(caller, entity, animationId, target)
    local targ = tpz.commands.getTargetMob(caller, entity, target)
    local usage = "!mobsub <animation ID> {mob ID}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a valid mobID.", usage)
        return
    end

    -- validate animationId
    animationId = tonumber(animationId) or tpz.anim[string.upper(animationId)]
    if (animationId == nil or animationId < 0) then
        tpz.commands.error(caller, entity, "Invalid animation ID.", usage)
        return
    end

    -- set animation sub
    targ:AnimationSub(animationId)
end
