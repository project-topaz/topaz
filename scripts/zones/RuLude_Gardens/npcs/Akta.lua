-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Akta
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    local FellowQuest = player:getCharVar("[Quest]Unlisted_Qualities")
    if player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.UNLISTED_QUALITIES) == QUEST_ACCEPTED and player:getMaskBit(FellowQuest,0) == false then
        player:startEvent(10103,0,0,0,0,0,0,0,player:getFellowValue("fellowid"))
    else
        player:startEvent(116)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 10103 and option >= 1 and option <= 3 then
        player:setFellowValue("size", option*4)
        player:setMaskBit(player:getCharVar("[Quest]Unlisted_Qualities"),"[Quest]Unlisted_Qualities",0,true)
    end
--[[
Adventuring Fellow Size Options:
    3   Pretty tall
    2   Around average
    1   On the small side
--]]
end