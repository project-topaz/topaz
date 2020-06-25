---------------------------------------------------------------------------------------------------
-- func: release
-- desc: Releases the player from current events.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "t"
}

function onTrigger(caller, player, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)

    targ:release()
end
