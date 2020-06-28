---------------------------------------------------------------------------------------------------
-- func: hasitem
-- desc: Checks if a player has a specific item
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 2,
    parameters = "it"
}

function onTrigger(caller, entity, itemId, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!hasitem <itemID> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate itemId
    if (itemId == nil) then
        tpz.commands.error(caller, entity, "You must provide an itemID.", usage)
        return
    elseif (itemId < 1) then
        tpz.commands.error(caller, entity, "Invalid itemID.", usage)
        return
    end

    -- report hasItem
    if (targ:hasItem(itemId)) then
        tpz.commands.print(caller, entity, string.format("%s has item %i.", targ:getName(), itemId))
    else
        tpz.commands.print(caller, entity, string.format("%s does not have item %i.", targ:getName(), itemId))
    end
end
