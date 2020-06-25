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

function onTrigger(caller, player, target, rank)
    local usage = "!setrank <player> <new rank>"
    local targ = tpz.commands.getTargetPC(player, target)

    if rank == nil or (rank < 1 or rank > 10) then
        tpz.commands.error(caller, player, "Improper rank passed. Valid Values: 1 to 10", usage)
        return
    end

    targ:setRank(rank)
    tpz.commands.print(caller, player, string.format("You set %s's rank to %d", target, rank))
end
