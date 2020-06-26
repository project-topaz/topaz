---------------------------------------------------------------------------------------------------
-- func: addtreasure <itemId> <target player/party/alliance>
-- desc: Adds an item directly to the treasure pool.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "iti"
}

function onTrigger(caller, player, itemId, target, dropper)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!addtreasure <itemID> {player} {npcID}"

    -- validate itemId
    if (itemId ~= nil) then
        itemId = tonumber(itemId)
    end
    if (itemId == nil or itemId == 0) then
        tpz.commands.error(caller, player, "Invalid itemID.", usage)
        return
    end

    -- validate dropper
    if (dropper ~= nil) then
        dropper = GetNPCByID(dropper)
        if (dropper == nil) then
            tpz.commands.error(caller, player, "Invalid npcID.", usage)
            return
        end
    end

    -- add treasure to pool
    targ:addTreasure(itemId, dropper)
    tpz.commands.print(caller, player, string.format("Item of ID %d was added to the treasure pool of %s or their party/alliance.", itemId, targ:getName()))
end
