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

function onTrigger(caller, entity, cp)
    local usage = "!cp <amount>"
    -- validate amount
    if (cp == nil or cp == 0) then
        tpz.commands.error(caller, entity, "Invalid amount.")
        return
    end

    -- add cp
    entity:addCP(cp)
    tpz.commands.print(caller, entity, string.format("Added %i cp to %s.", cp, entity:getName()))
end
