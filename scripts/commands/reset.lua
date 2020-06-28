-----------------------------------------------------------------------
-- func: reset <player>
-- desc: If no name is specified, resets your own JA timers.
-- If a player name is specified, resets all of that players JA timers.
-----------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "t"
}

function onTrigger(caller, entity, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!reset {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- reset target recasts
    targ:resetRecasts()
    if (targ:getID() ~= caller) then
        tpz.commands.print(caller, entity, string.format("Reset %s's recast timers.", targ:getName()))
    end
end
