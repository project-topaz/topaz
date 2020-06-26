---------------------------------------------------------------------------------------------------
-- func: completequest <logID> <questID> <player>
-- desc: Completes the given quest for the GM or target player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/quests")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "sst"
}

function onTrigger(caller, player, logId, questId, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!completequest <logID> <questID> {player}"

    -- validate logId
    local questLog = GetQuestLogInfo(logId)
    if (questLog == nil) then
        tpz.commands.error(caller, player, "Invalid logID.", usage)
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
        tpz.commands.error(caller, player, "Invalid questID.", usage)
        return
    end

    -- complete quest
    targ:completeQuest(logId, questId)
    tpz.commands.print(caller, player, string.format("Completed %s Quest with ID %u for %s", logName, questId, targ:getName()))
end
