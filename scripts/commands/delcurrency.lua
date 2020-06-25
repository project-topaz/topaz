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

function onTrigger(caller, player, currency, amount, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!delcurrency <currency type> <amount> {player}"

    -- validate currency
    -- note: getCurrency does not ever return nil at the moment.  will work on this in future update.
    if (currency == nil or targ:getCurrency(currency) == nil) then
        tpz.commands.error(caller, player, "Invalid currency type.", usage)
        return
    end

    -- validate amount
    local currentAmount = targ:getCurrency(currency)
    if (amount == nil or amount < 1) then
        tpz.commands.error(caller, player, "Invalid amount.", usage)
        return
    end
    if (amount > currentAmount) then
        amount = currentAmount
    end

    -- delete currency
    targ:delCurrency(currency, amount)
    local newAmount = targ:getCurrency(currency)
    tpz.commands.print(caller, player, string.format("%i %s was taken from %s, for a total of %i.", amount, currency, targ:getName(), newAmount))
end
