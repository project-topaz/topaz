---------------------------------------------------------------------------------------------------
-- func: takegil <amount> <player>
-- desc: Removes the amount of gil from the given player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "it"
}

function onTrigger(caller, entity, amount, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!takegil <amount> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate amount
    local oldAmount = targ:getGil()
    if (amount == nil or amount < 1) then
        tpz.commands.error(caller, entity, "Invalid amount of gil.", usage)
        return
    end
    if (amount > oldAmount) then
        amount = oldAmount
    end

    -- remove gil
    targ:delGil(amount)
    tpz.commands.print(caller, entity, string.format("Removed %i gil from %s. They now have %i gil.", amount, targ:getName(), targ:getGil()))

end
