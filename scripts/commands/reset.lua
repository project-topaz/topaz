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

function onTrigger(caller, player, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!reset {player}"

    -- reset target recasts
    targ:resetRecasts()
    if (targ:getID() ~= player:getID()) then
        tpz.commands.print(caller, player, string.format("Reset %s's recast timers.", targ:getName()))
    end
end
