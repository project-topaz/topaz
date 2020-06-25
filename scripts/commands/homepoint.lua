---------------------------------------------------------------------------------------------------
-- func: homepoint
-- desc: Sends the target to their homepoint.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "t"
}

function onTrigger(caller, player, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)

    -- homepoint target
    targ:warp()
    if (targ:getID() ~= caller) then
        tpz.commands.print(caller, player, string.format("Sent %s to their homepoint.", targ:getName()))
    end
end
