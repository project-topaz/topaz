---------------------------------------------------------------------------------------------------
-- func: addcurrency <currency type> <amount> <target player>
-- desc: Adds the specified currency to the player
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "sit"
}

function onTrigger(caller, entity, currency, amount, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!addcurrency <currency type> <amount> {player}"
    
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
    if (amount == nil or amount < 1) then
        tpz.commands.error(caller, entity, "Invalid amount.", usage)
        return
    end

    -- add currency
    targ:addCurrency(currency,amount)
    local newAmount = targ:getCurrency(currency)
    tpz.commands.print(caller, entity, string.format("%s was given %i %s, for a total of %i." ,targ:getName(), amount, currency, newAmount))
end
