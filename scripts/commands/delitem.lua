---------------------------------------------------------------------------------------------------
-- func: delitem
-- desc: Deletes a single item held by a player, if they have it.
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "it"
}

function onTrigger(caller, entity, itemId, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!delitem <itemID> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate itemId
    if (itemId == nil or itemId < 1) then
        tpz.commands.error(caller, entity,"Invalid itemID.", usage)
        return
    end

    -- search target inventory for item, and delete if found
    for i = tpz.inv.INVENTORY, tpz.inv.WARDROBE4 do -- inventory locations enums
        if (targ:hasItem(itemId, i)) then
            targ:delItem(itemId, 1, i)
            tpz.commands.print(caller, entity, string.format("Item %i was deleted from %s.", itemId, targ:getName()))
            break
        end
        if (i == tpz.inv.WARDROBE4) then -- Wardrobe 4 is the last inventory location, if it reaches this point then the player does not have the item anywhere.
            tpz.commands.print(caller, entity, string.format("%s does not have item %i.", targ:getName(), itemId))
        end
    end

end
