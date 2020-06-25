---------------------------------------------------------------------------------------------------
-- func: setgil
-- desc: Sets the players gil.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function onTrigger(caller, player, amount)
    local usage = "!setgil <amount>"

    -- validate amount
    if (amount == nil or amount < 0) then
        tpz.commands.error(caller, player, "Invalid amount.", usage)
        return
    end

    player:setGil(amount)
    tpz.commands.print(caller, player, string.format("%s's gil was set to %i.", player:getName(), amount))
end
