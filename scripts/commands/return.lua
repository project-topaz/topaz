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

function onTrigger(caller, entity, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!return {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- get previous zone
    zoneId = targ:getPreviousZone()
    if (zoneId == nil or zoneId == tpz.zone.UNKNOWN or zoneId == tpz.zone.RESIDENTIAL_AREA) then
        tpz.commands.error(caller, entity, "Previous zone was a Mog House or there was a problem fetching the ID.", usage)
        return
    end

    -- zone target
    targ:setPos(0, 0, 0, 0, zoneId)
    if (targ:getID() ~= caller) then
        tpz.commands.print(caller, entity, string.format("%s was returned to zone %i.", targ:getName(), zoneId))
    end
end
