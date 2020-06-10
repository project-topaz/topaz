---------------------------------------------------------------------------------------------------
-- func: completemission <logID> <missionID> <player>
-- desc: Completes the given mission for the target player, if that mission is currently active.
-- https://wiki.dspt.info/index.php/Log_IDs#Mission_Log_IDs


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

cmdprops =
{
    permission = 4,
    parameters = "sss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!completemission <logID> <missionID> {player}")
end

function onTrigger(player, logId, missionId, target)

    -- validate logId
    local logName
    local logInfo = GetMissionLogInfo(logId)
    if (logInfo == nil) then
        error(player, "Invalid logID.")
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
        error(player, "Invalid missionID.")
        return
    end

    -- validate target
    local targ
    if (target == nil) then
        targ = player
    else
        targ = GetPlayerByName(target)
        if (targ == nil) then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    -- complete mission
    targ:completeMission( logId, missionId )
    player:PrintToPlayer( string.format( "Completed %s Mission with ID %u for %s", logName, missionId, targ:getName() ) )
end
