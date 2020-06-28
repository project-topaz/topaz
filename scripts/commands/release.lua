---------------------------------------------------------------------------------------------------
-- func: release
-- desc: Releases the player from current events.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "t"
}

function onTrigger(caller, entity, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!release {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    targ:release()
end
