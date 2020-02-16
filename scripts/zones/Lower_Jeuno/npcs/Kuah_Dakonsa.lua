-----------------------------------
-- Area: Lower Jeuno
-- !pos: -42 0 -65 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    local FellowQuest = player:getCharVar("[Quest]Unlisted_Qualities")
    if (player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.UNLISTED_QUALITIES) == QUEST_ACCEPTED and player:getMaskBit(FellowQuest,2) == false) then
        player:startEvent(20000,0,0,0,0,0,0,0,player:getFellowValue("fellowid"))
    else
        player:startEvent(190)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 20000 and option >= 0 and option <= 15 then
        player:setFellowValue("face", option)
        player:setMaskBit(player:getCharVar("[Quest]Unlisted_Qualities"),"[Quest]Unlisted_Qualities",2,true)
    end
--[[
Adventuring Fellow Face Options:
    0   1A
    1   1B
    2   2A
    3   2B
    4   3A
    5   3B
    6   4A
    7   4B
    8   5A
    9   5B
    10  6A
    11  6B
    12  7A
    13  7B
    14  8A
    15  8B
--]]
end