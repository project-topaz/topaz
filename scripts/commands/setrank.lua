---------------------------------------------------------------------------------------------------
-- func: setrank
-- desc: Sets the players rank.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "ti"
}

function onTrigger(caller, entity, target, rank)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!setrank <player> <new rank>"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    if rank == nil or (rank < 1 or rank > 10) then
        tpz.commands.error(caller, entity, "Improper rank passed. Valid Values: 1 to 10", usage)
        return
    end

    targ:setRank(rank)
    tpz.commands.print(caller, entity, string.format("You set %s's rank to %d", target, rank))
end
