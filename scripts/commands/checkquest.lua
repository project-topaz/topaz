---------------------------------------------------------------------------------------------------
-- func: !checkquest <logID> <questID> {player}
-- desc: Prints status of the quest to the in game chatlog
---------------------------------------------------------------------------------------------------

require("scripts/globals/quests")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "sst"
}

function onTrigger(caller, entity, logId, questId, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!checkquest <logID> <questID> {player}"

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

    -- get quest status
    local status = targ:getQuestStatus(logId,questId)
    switch (status): caseof
    {
        [0] = function (x) status = "AVAILABLE" end,
        [1] = function (x) status = "ACCEPTED" end,
        [2] = function (x) status = "COMPLETED" end,
    }

    -- show quest status
    tpz.commands.print(caller, entity, string.format("%s's status for %s quest ID %i is: %s", targ:getName(), logName, questId, status))
end
