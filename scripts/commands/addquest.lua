---------------------------------------------------------------------------------------------------
-- func: addquest <logID> <questID> <player>
-- desc: Adds a quest to the given targets log.
---------------------------------------------------------------------------------------------------

require("scripts/globals/quests")
require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "sst"
}

function onTrigger(caller, entity, logId, questId, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!adddynatime <minutes> {player}"

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

    -- add quest
    targ:addQuest(logId, questId)
    tpz.commands.print(caller, entity, string.format("Added %s quest %i to %s.", logName, questId, targ:getName()))
end
