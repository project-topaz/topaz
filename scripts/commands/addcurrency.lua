---------------------------------------------------------------------------------------------------
-- func: addcurrency <currency type> <amount> <target player>
-- desc: Adds the specified currency to the player
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 4,
    parameters = "sit"
}

require("scripts/globals/commands")

function onTrigger(caller, player, currency, amount, target)
    local usage = "!addcurrency <currency type> <amount> {player}"
    local targ = tpz.commands.getTarget(player, target)

    -- validate currency
    -- note: getCurrency does not ever return nil at the moment.  will work on this in future update.
    if (currency == nil or targ:getCurrency(currency) == nil) then
        tpz.commands.error(caller, player, "Invalid currency type.", usage)
        return
    end

    -- validate amount
    if (amount == nil or amount < 1) then
        tpz.commands.error(caller, player, "Invalid amount.", usage)
        return
    end

    -- add currency
    targ:addCurrency(currency,amount)
    local newAmount = targ:getCurrency(currency)
    tpz.commands.print(caller, player, string.format("%s was given %i %s, for a total of %i." ,targ:getName(), amount, currency, newAmount))
end
