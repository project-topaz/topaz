---------------------------------------------------------------------------------------------------
-- func: addkeyitem <ID> <player>
-- desc: Adds a key item to the player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/keyitems")
require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "st"
}

function onTrigger(caller, entity, keyId, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!addkeyitem <key item ID> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate key item id
    if (keyId == nil) then
        tpz.commands.error(caller, entity, "You must supply a Key Item ID.", usage)
        return
    end
    keyId = tonumber(keyId) or tpz.ki[string.upper(keyId)]
    if (keyId == nil or keyId == 0) then
        tpz.commands.error(caller, entity, "Invalid Key Item ID.", usage)
        return
    end

    -- add key item to target
    if (targ:hasKeyItem(keyId)) then
        tpz.commands.print(caller, entity, string.format("%s already has key item %i.", targ:getName(), keyId))
    else
        local ID = zones[targ:getZoneID()]
        targ:addKeyItem(keyId)
        targ:messageSpecial(ID.text.KEYITEM_OBTAINED, keyId)
        tpz.commands.print(caller, entity, string.format("Key item %i was given to %s.", keyId, targ:getName()))
    end
end
