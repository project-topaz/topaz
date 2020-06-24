---------------------------------------------------------------------------------------------------
-- func: addallmounts
-- desc: Adds all mount key items to player, granting access to their associated mounts
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "t"
}

function onTrigger(caller, player, target)
    local targ = tpz.commands.getTarget(player, target)

    -- add all mount key items
    for i = tpz.ki.CHOCOBO_COMPANION, tpz.ki.CHOCOBO_COMPANION + 26 do
        targ:addKeyItem(i)
    end

    tpz.commands.print(caller, player, string.format("%s now has all mounts.", targ:getName()))
end
