---------------------------------------------------------------------------------------------------
-- func: addallmounts
-- desc: Adds all mount key items to player, granting access to their associated mounts
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "t"
}

function onTrigger(caller, entity, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "addallmounts {player}"
    
    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- add all mount key items
    for i = tpz.ki.CHOCOBO_COMPANION, tpz.ki.CHOCOBO_COMPANION + 26 do
        targ:addKeyItem(i)
    end

    tpz.commands.print(caller, entity, string.format("%s now has all mounts.", targ:getName()))
end
