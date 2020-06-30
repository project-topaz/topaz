---------------------------------------------------------------------------------------------------
-- func: checkmission <Log ID> <Player>
-- desc: Prints current MissionID for the given LogID and target Player to the in game chatlog
---------------------------------------------------------------------------------------------------

require("scripts/globals/missions")
require("scripts/globals/commands")

cmdprops =
{
    permission = 2,
    parameters = "st"
}

function onTrigger(caller, player, logId, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!checkmission <logID> {player}"

    -- validate logId
    local logName
    local logInfo = GetMissionLogInfo(logId)
    if (logInfo == nil) then
        tpz.commands.error(caller, player, "Invalid logID.", usage)
        return
    end
    logName = logInfo.full_name
    logId = logInfo.mission_log

    -- report mission
    local currentMission = targ:getCurrentMission(logId)

    if ((logId <= 3) and (currentMission == 65535)) then
        tpz.commands.print(caller, player, string.format("No current %s mission for %s.", logName, targ:getName()))
    else
        tpz.commands.print(caller, player, string.format("Current %s Mission ID is %s for %s.", logName, currentMission, targ:getName()))
    end
end
