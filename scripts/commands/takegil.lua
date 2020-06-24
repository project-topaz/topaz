---------------------------------------------------------------------------------------------------
-- func: takegil <amount> <player>
-- desc: Removes the amount of gil from the given player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "it"
}

function onTrigger(caller, player, amount, target)
    local usage = "!takegil <amount> {player}"
    local targ = tpz.commands.getTarget(player, target)

    -- validate amount
    local oldAmount = targ:getGil()
    if (amount == nil or amount < 1) then
        tpz.commands.error(caller, player, "Invalid amount of gil.", usage)
        return
    end
    if (amount > oldAmount) then
        amount = oldAmount
    end

    -- remove gil
    targ:delGil(amount)
    tpz.commands.print(caller, player, string.format("Removed %i gil from %s. They now have %i gil.", amount, targ:getName(), targ:getGil()))

end
