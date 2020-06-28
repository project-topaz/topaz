---------------------------------------------------------------------------------------------------
-- func: completequest <logID> <questID> <player>
-- desc: Completes the given quest for the GM or target player.
-- https://wiki.dspt.info/index.php/Log_IDs#Quest_Log_IDs

-- Quest Log ID	Quest Log Name
-- 0	SANDORIA
-- 1	BASTOK
-- 2	WINDURST
-- 3	JEUNO
-- 4	OTHER_AREAS_LOG
-- 5	OUTLANDS
-- 6	TOAU
-- 7	WOTG
-- 8	ABYSSEA
-- 9	SOA
-- 10	COALITION
---------------------------------------------------------------------------------------------------

require("scripts/globals/quests")
require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "sst"
}

function onTrigger(caller, entity, logId, questId, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!completequest <logID> <questID> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate logId
    local questLog = GetQuestLogInfo(logId)
    if (questLog == nil) then
        tpz.commands.error(caller, entity, "Invalid logID.", usage)
        return
    end
    local logName = questLog.full_name
    logId = questLog.quest_log

    -- validate questId
    local areaQuestIds = tpz.quest.id[tpz.quest.area[logId]]
    if (questId ~= nil) then
        questId = tonumber(questId) or areaQuestIds[string.upper(questId)]
    end
    if (questId == nil or questId < 0) then
        tpz.commands.error(caller, entity, "Invalid questID.", usage)
        return
    end

    -- complete quest
    targ:completeQuest(logId, questId)
    tpz.commands.print(caller, entity, string.format("Completed %s Quest with ID %u for %s", logName, questId, targ:getName()))
end
