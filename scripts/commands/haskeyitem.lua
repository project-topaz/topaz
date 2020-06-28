---------------------------------------------------------------------------------------------------
-- func: haskeyitem <ID> <player>
-- desc: Checks if player has specified KeyItem.
--       Can use either of number or the variable string from keyitems.lua
---------------------------------------------------------------------------------------------------

require("scripts/globals/keyitems")
require("scripts/globals/commands")

cmdprops =
{
    permission = 2,
    parameters = "st"
}

function onTrigger(caller, entity, keyId, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!haskeyitem <key item ID> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate itemId
    if (keyId == nil) then
        tpz.commands.error(caller, entity, "You must provide a key item ID.", usage)
        return
    else
        keyId = tonumber(keyId) or tpz.ki[string.upper(keyId)]
        if (keyId == nil or keyId < 1) then
            tpz.commands.error(caller, entity, "Invalid key item ID.", usage)
            return
        end
    end

    -- report hasKeyItem
    if (targ:hasKeyItem(keyId)) then
        tpz.commands.print(caller, entity, string.format("%s has key item %i.", targ:getName(), keyId))
    else
        tpz.commands.print(caller, entity, string.format("%s does not have key item %i.", targ:getName(), keyId))
    end
end
