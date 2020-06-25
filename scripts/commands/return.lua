---------------------------------------------------------------------------------------------------
-- func: return <player>
-- desc: Warps GM or target player to their previous zone
---------------------------------------------------------------------------------------------------

require("scripts/globals/zone")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "t"
}

function onTrigger(caller, player, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!return {player}"

    -- get previous zone
    zoneId = targ:getPreviousZone()
    if (zoneId == nil or zoneId == tpz.zone.UNKNOWN or zoneId == tpz.zone.RESIDENTIAL_AREA) then
        tpz.commands.error(caller, player, "Previous zone was a Mog House or there was a problem fetching the ID.", usage)
        return
    end

    -- zone target
    targ:setPos(0, 0, 0, 0, zoneId)
    if (targ:getID() ~= player:getID()) then
        tpz.commands.print(caller, player, string.format("%s was returned to zone %i.", targ:getName(), zoneId))
    end
end
