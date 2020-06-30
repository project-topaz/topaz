---------------------------------------------------------------------------------------------------
-- func: !checkquest <logID> <questID> {player}
-- desc: Prints status of the quest to the in game chatlog
---------------------------------------------------------------------------------------------------

require("scripts/globals/quests")
require("scripts/globals/commands")

cmdprops =
{
    permission = 2,
    parameters = "sst"
}

function onTrigger(caller, player, logId, questId, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!checkquest <logID> <questID> {player}"

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

    -- get quest status
    local status = targ:getQuestStatus(logId,questId)
    switch (status): caseof
    {
        [0] = function (x) status = "AVAILABLE" end,
        [1] = function (x) status = "ACCEPTED" end,
        [2] = function (x) status = "COMPLETED" end,
    }

    -- show quest status
    tpz.commands.print(caller, player, string.format("%s's status for %s quest ID %i is: %s", targ:getName(), logName, questId, status))
end
