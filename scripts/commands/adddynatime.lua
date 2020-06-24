---------------------------------------------------------------------------------------------------
-- func: adddynatime
-- desc: Adds an amount of time to the given target. If no target then to the current player.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "it"
}

require("scripts/globals/commands")

function onTrigger(caller, player, minutes, target)
    local usage = "!adddynatime <minutes> {player}"
    local targ = tpz.commands.getTarget(player, target)

    -- target must be in dynamis
    local effect = targ:getStatusEffect(tpz.effect.DYNAMIS)
    if not effect then
        tpz.commands.error(caller, player, string.format("%s is not in Dynamis.", targ:getName()), usage)
        return
    end

    -- validate amount
    if minutes == nil or minutes < 1 then
        tpz.commands.error(caller, player, "Invalid number of minutes.", usage)
        return
    end

    -- add time
    local zoneId = targ:getZoneID()
    local ID = zones[zoneId]
    local old_duration = effect:getDuration()
    effect:setDuration((old_duration + (minutes * 60)) * 1000)
    targ:setLocalVar("dynamis_lasttimeupdate", effect:getTimeRemaining() / 1000)
    targ:messageSpecial(ID.text.DYNAMIS_TIME_EXTEND, minutes)
end
