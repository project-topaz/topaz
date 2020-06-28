---------------------------------------------------------------------------------------------------
-- func: giveitem <player> <itemId> <amount> <aug1> <v1> <aug2> <v2> <aug3> <v3> <aug4> <v4>
-- desc: Gives an item to the target player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "tiiiiiiiiii"
}

function onTrigger(caller, entity, target, itemId, amount, aug0, aug0val, aug1, aug1val, aug2, aug2val, aug3, aug3val)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!giveitem <player> <itemId> <amount> <aug1> <v1> <aug2> <v2> <aug3> <v3> <aug4> <v4>"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    if (itemId == nil) then
        tpz.commands.print(caller, entity, "You must enter a item ID.")
        return
    end

    -- Load needed text ids for target's current zone..
    local ID = zones[targ:getZoneID()]

    -- validate itemId
    if (itemId == nil or tonumber(itemId) == nil or tonumber(itemId) == 0) then
        error(player, "Invalid itemId.");
        return;
    end
	
    -- Attempt to give the target the item..
    if (targ:getFreeSlotsCount() == 0) then
        targ:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemId)
        tpz.commands.print(caller, entity, string.format("Player '%s' does not have free space for that item!", target))
    else
        targ:addItem(itemId, amount, aug0, aug0val, aug1, aug1val, aug2, aug2val, aug3, aug3val)
        targ:messageSpecial(ID.text.ITEM_OBTAINED, itemId)
        tpz.commands.print(caller, entity, string.format("Gave player '%s' Item with ID of '%u' ", target, itemId))
    end
end
