---------------------------------------------------------------------------------------------------
-- func: animatesubnpc
-- desc: Changes the animationSub of the given npc. (For testing purposes.)
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 5,
    parameters = "ss"
}

function onTrigger(caller, player, animationId, target)
    local targ = tpz.commands.getTargetNPC(caller, player, target)
    local usage = "!animatesubnpc <animationID> {npcID}"

    -- validate animationID
    if (animationId ~= nil) then
        animationId = tonumber(animationId) or tpz.anim[string.upper(animationId)]
    end
    if (animationId == nil) then
        tpz.commands.error(caller, player, "Invalid animationID.", usage)
        return
    end

    local oldAnimation = targ:AnimationSub()
    targ:AnimationSub(animationId)
    tpz.commands.print(caller, player, string.format("NPC ID: %i - %s | Old animationSub: %i | New animationSub: %i\n", targ:getID(), targ:getName(), oldAnimation, animationId))
end
