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

function onTrigger(caller, entity, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!logoff {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- logoff target
    targ:leavegame()
    if (targ:getID() ~= caller) then
        tpz.commands.print(caller, entity, string.format("%s has been logged off.", targ:getName()))
    end
end
