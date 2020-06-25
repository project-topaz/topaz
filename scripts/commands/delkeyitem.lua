---------------------------------------------------------------------------------------------------
-- func: delkeyitem
-- desc: Deletes the given key item from the player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/keyitems")
require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "st"
}

function onTrigger(caller, player, keyId, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!delkeyitem <key item ID> {player}"

    -- validate key item id
    if (keyId == nil) then
        tpz.commands.error(caller, player, "You must supply a key item ID.", usage)
        return
    end
    keyId = tonumber(keyId) or tpz.ki[string.upper(keyId)]
    if (keyId == nil or keyId < 1) then
        tpz.commands.error(caller, player, "Invalid Key Item ID.", usage)
        return
    end

    -- delete key item from target
    if (targ:hasKeyItem(keyId)) then
        local ID = zones[targ:getZoneID()]
        targ:delKeyItem( keyId )
        targ:messageSpecial(ID.text.KEYITEM_OBTAINED + 1, keyId)
        tpz.commands.print(caller, player, string.format("Key item %i deleted from %s.", keyId, targ:getName()))
    else
        tpz.commands.print(caller, player, string.format("%s does not have key item %i.", targ:getName(), keyId))
    end
end
