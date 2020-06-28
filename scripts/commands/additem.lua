---------------------------------------------------------------------------------------------------
-- func: additem <itemId> <quantity> <aug1> <v1> <aug2> <v2> <aug3> <v3> <aug4> <v4> <trial>
-- desc: Adds an item to the GMs inventory.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 2,
    parameters = "iiiiiiiiiii"
}

function onTrigger(caller, entity, itemId, quantity, aug0, aug0val, aug1, aug1val, aug2, aug2val, aug3, aug3val, trialId)
    local usage = "!additem <itemId> {quantity} {aug1} {v1} {aug2} {v2} {aug3} {v3} {aug4} {v4} {trial}"

    -- Load needed text ids for players current zone..
    local ID = zones[entity:getZoneID()]

    -- validate itemId
    if (itemId == nil or tonumber(itemId) == nil or tonumber(itemId) == 0) then
        tpz.commands.error(caller, entity, "Invalid itemId.", usage)
        return
    end

    -- Ensure the GM has room to obtain the item...
    if (entity:getFreeSlotsCount() == 0) then
        entity:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemId)
        return
    end

    -- Give the GM the item...
    entity:addItem(itemId, quantity, aug0, aug0val, aug1, aug1val, aug2, aug2val, aug3, aug3val, trialId)
    entity:messageSpecial(ID.text.ITEM_OBTAINED, itemId)
end
