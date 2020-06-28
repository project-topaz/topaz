---------------------------------------------------------------------------------------------------
-- func: animatesubnpc
-- desc: Changes the animationSub of the given npc. (For testing purposes.)
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 5,
    parameters = "sn"
}

function onTrigger(caller, entity, animationId, target)
    local targ = tpz.commands.getTargetNPC(caller, entity, target)
    local usage = "!animatesubnpc <animationID> {npcID}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a valid npcID.", usage)
        return
    end

    -- validate animationID
    if (animationId ~= nil) then
        animationId = tonumber(animationId) or tpz.anim[string.upper(animationId)]
    end
    if (animationId == nil) then
        tpz.commands.error(caller, entity, "Invalid animationID.", usage)
        return
    end

    local oldAnimation = targ:AnimationSub()
    targ:AnimationSub(animationId)
    tpz.commands.print(caller, entity, string.format("NPC ID: %i - %s | Old animationSub: %i | New animationSub: %i\n", targ:getID(), targ:getName(), oldAnimation, animationId))
end
