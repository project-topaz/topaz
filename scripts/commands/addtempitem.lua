---------------------------------------------------------------------------------------------------
-- func: addtempitem
-- desc: Adds a temp item to the players inventory.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "ii"
}

function onTrigger(caller, player, itemId, quantity)
    local usage = "!addtempitem <itemID> <quantity>"

    -- validate itemId
    if (itemId ~= nil) then
        itemId = tonumber(itemId)
    end
    if (itemId == nil or itemId == 0) then
        tpz.commands.error(caller, player, "Invalid itemID.", usage)
        return
    end

    -- validate quantity
    quantity = tonumber(quantity) or 1
    if (quantity == nil or quantity < 1) then
        tpz.commands.error(caller, player, "Invalid quantity.", usage)
        return
    end

    -- add temp item
    player:addTempItem(itemId, quantity, 0, 0, 0, 0, 0, 0, 0, 0)
end
