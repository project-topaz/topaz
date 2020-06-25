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

function onTrigger(caller, player, keyId, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!haskeyitem <key item ID> {player}"

    -- validate itemId
    if (keyId == nil) then
        tpz.commands.error(caller, player, "You must provide a key item ID.", usage)
        return
    else
        keyId = tonumber(keyId) or tpz.ki[string.upper(keyId)]
        if (keyId == nil or keyId < 1) then
            tpz.commands.error(caller, player, "Invalid key item ID.", usage)
            return
        end
    end

    -- report hasKeyItem
    if (targ:hasKeyItem(keyId)) then
        tpz.commands.print(caller, player, string.format("%s has key item %i.", targ:getName(), keyId))
    else
        tpz.commands.print(caller, player, string.format("%s does not have key item %i.", targ:getName(), keyId))
    end
end
