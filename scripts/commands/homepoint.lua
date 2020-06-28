---------------------------------------------------------------------------------------------------
-- func: homepoint
-- desc: Sends the target to their homepoint.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 2,
    parameters = "t"
}

function onTrigger(caller, entity, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!homepoint {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- homepoint target
    targ:warp()
    if (targ:getID() ~= caller) then
        tpz.commands.print(caller, entity, string.format("Sent %s to their homepoint.", targ:getName()))
    end
end
