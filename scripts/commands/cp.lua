---------------------------------------------------------------------------------------------------
-- func: cp
-- desc: Adds the given amount cp to the player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "i"
}

function onTrigger(caller, player, cp)
    local usage = "!cp <amount>"
    -- validate amount
    if (cp == nil or cp == 0) then
        tpz.commands.error(caller, player, "Invalid amount.")
        return
    end

    -- add cp
    player:addCP(cp)
    tpz.commands.print(caller, player, string.format("Added %i cp to %s.", cp, player:getName()))
end
