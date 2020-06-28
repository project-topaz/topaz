---------------------------------------------------------------------------------------------------
-- func: delcurrency <currency type> <amount> <target player>
-- desc: Removes the specified currency from the player
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "sit"
}

function onTrigger(caller, entity, currency, amount, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!delcurrency <currency type> <amount> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate currency
    -- note: getCurrency does not ever return nil at the moment.  will work on this in future update.
    if (currency == nil or targ:getCurrency(currency) == nil) then
        tpz.commands.error(caller, entity, "Invalid currency type.", usage)
        return
    end

    -- validate amount
    local currentAmount = targ:getCurrency(currency)
    if (amount == nil or amount < 1) then
        tpz.commands.error(caller, entity, "Invalid amount.", usage)
        return
    end
    if (amount > currentAmount) then
        amount = currentAmount
    end

    -- delete currency
    targ:delCurrency(currency, amount)
    local newAmount = targ:getCurrency(currency)
    tpz.commands.print(caller, entity, string.format("%i %s was taken from %s, for a total of %i.", amount, currency, targ:getName(), newAmount))
end
