---------------------------------------------------------------------------------------------------
-- func: completemission <logID> <missionID> <player>
-- desc: Completes the given mission for the target player, if that mission is currently active.
---------------------------------------------------------------------------------------------------

require("scripts/globals/missions")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "sst"
}

function onTrigger(caller, entity, logId, missionId, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!completemission <logID> <missionID> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate logId
    local logName
    local logInfo = GetMissionLogInfo(logId)
    if (logInfo == nil) then
        tpz.commands.error(caller, entity, "Invalid logID.", usage)
        return
    end
    logName = logInfo.full_name
    logId = logInfo.mission_log

    -- validate missionId
    local areaMissionIds = tpz.mission.id[tpz.mission.area[logId]]
    if (missionId ~= nil) then
        missionId = tonumber(missionId) or areaMissionIds[string.upper(missionId)] or _G[string.upper(missionId)]
    end
    if (missionId == nil or missionId < 0) then
        tpz.commands.error(caller, entity, "Invalid missionID.", usage)
        return
    end

    -- complete mission
    targ:completeMission(logId, missionId)
    tpz.commands.print(caller, entity, string.format("Completed %s Mission with ID %u for %s", logName, missionId, targ:getName()))
end
