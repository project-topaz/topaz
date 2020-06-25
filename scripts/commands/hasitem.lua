---------------------------------------------------------------------------------------------------
-- func: hasitem
-- desc: Checks if a player has a specific item
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "it"
}

function onTrigger(caller, player, itemId, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!hasitem <itemID> {player}"

    -- validate itemId
    if (itemId == nil) then
        tpz.commands.error(caller, player, "You must provide an itemID.", usage)
        return
    elseif (itemId < 1) then
        tpz.commands.error(caller, player, "Invalid itemID.", usage)
        return
    end

    -- report hasItem
    if (targ:hasItem(itemId)) then
        tpz.commands.print(caller, player, string.format("%s has item %i.", targ:getName(), itemId))
    else
        tpz.commands.print(caller, player, string.format("%s does not have item %i.", targ:getName(), itemId))
    end
end
