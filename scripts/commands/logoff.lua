---------------------------------------------------------------------------------------------------
-- func: logoff
-- desc: Logs the target player off by force.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "t"
}

function onTrigger(caller, player, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!logoff {player}"

    -- logoff target
    targ:leavegame()
    if (targ:getID() ~= caller) then
        tpz.commands.print(caller, player, string.format("%s has been logged off.", targ:getName()))
    end
end
