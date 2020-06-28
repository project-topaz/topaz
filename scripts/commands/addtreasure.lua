---------------------------------------------------------------------------------------------------
-- func: addtreasure <itemId> <target player/party/alliance>
-- desc: Adds an item directly to the treasure pool.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "iti"
}

function onTrigger(caller, entity, itemId, target, dropper)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!addtreasure <itemID> {player} {npcID}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate itemId
    if (itemId ~= nil) then
        itemId = tonumber(itemId)
    end
    if (itemId == nil or itemId == 0) then
        tpz.commands.error(caller, entity, "Invalid itemID.", usage)
        return
    end

    -- validate dropper
    if (dropper ~= nil) then
        dropper = GetNPCByID(dropper)
        if (dropper == nil) then
            tpz.commands.error(caller, entity, "Invalid npcID.", usage)
            return
        end
    end

    -- add treasure to pool
    targ:addTreasure(itemId, dropper)
    tpz.commands.print(caller, entity, string.format("Item of ID %d was added to the treasure pool of %s or their party/alliance.", itemId, targ:getName()))
end
