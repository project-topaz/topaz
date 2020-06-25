---------------------------------------------------------------------------------------------------
-- func: delmission <logID> <missionID> <player>
-- desc: Deletes the given mission from the GM or target player.

-- Mission Log ID	Mission Log Name	Full Name
-- 			0		SANDORIA			Sandoria
-- 			1		BASTOK				Bastok
-- 			2		WINDURST			Windurst
-- 			3		ZILART				Rise of the Zilart
-- 			4		TOAU				Treasures of Aht Urhgan
-- 			5		WOTG				Wings of the Goddess
-- 			6		COP					Chains of Promathia
-- 			7		ASSAULT				Assault
-- 			8		CAMPAIGN			Campaign
-- 			9		ACP					A Crystalline Prophecy
-- 			10		AMK					A Moogle Kupo d'Etat
-- 			11		ASA					A Shantotto Ascension
-- 			12		SOA					Seekers of Adoulin
-- 			13		ROV					Rhapsodies of Vana'diel
---------------------------------------------------------------------------------------------------

require("scripts/globals/missions")
require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "sst"
}

function onTrigger(caller, player, logId, missionId, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!delmission <logID> <missionID> {player}"

    -- validate logId
    local logName
    local logInfo = GetMissionLogInfo(logId)
    if (logInfo == nil) then
        tpz.commands.error(caller, player, "Invalid logID.", usage)
        return
    end
    logId = logInfo.mission_log;
    logName = logInfo.full_name;

    -- validate missionId
    local areaMissionIds = tpz.mission.id[tpz.mission.area[logId]]
    if (missionId ~= nil) then
        missionId = tonumber(missionId) or areaMissionIds[string.upper(missionId)] or _G[string.upper(missionId)]
    end
    if (missionId == nil or missionId < 0) then
        tpz.commands.error(caller, player, "Invalid missionID.", usage)
        return
    end

    -- delete mission
    targ:delMission(logId, missionId)
    tpz.commands.print(caller, player, string.format("Deleted %s mission %i from %s.", logName, missionId, targ:getName()))
end
