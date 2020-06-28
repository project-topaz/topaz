---------------------------------------------------------------------------------------------------
-- func: setgil
-- desc: Sets the players gil.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "i"
}

function onTrigger(caller, entity, amount)
    local usage = "!setgil <amount>"

    -- validate amount
    if (amount == nil or amount < 0) then
        tpz.commands.error(caller, entity, "Invalid amount.", usage)
        return
    end

    entity:setGil(amount)
    tpz.commands.print(caller, entity, string.format("%s's gil was set to %i.", entity:getName(), amount))
end
