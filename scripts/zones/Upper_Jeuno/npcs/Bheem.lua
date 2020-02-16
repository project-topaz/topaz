-----------------------------------
-- Area: Upper Jeuno
--  NPC: Bheem
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/pets/fellow")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    local UnlistedQualities = player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.UNLISTED_QUALITIES)
    local UnlistedQualitiesProgress = player:getCharVar("[Quest]Unlisted_Qualities")
    local LookingGlass = player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS)
    local LookingGlassProgress = player:getCharVar("[Quest]Looking_Glass")
    local fellowParam = 0
    if UnlistedQualities >= QUEST_ACCEPTED and (UnlistedQualitiesProgress >= 7 or
        UnlistedQualitiesProgress == 0) then
        fellowParam = getFellowParam(player)
    end

    if UnlistedQualities == QUEST_ACCEPTED and UnlistedQualitiesProgress < 7 then
        player:startEvent(10037)
    elseif UnlistedQualities == QUEST_ACCEPTED and UnlistedQualitiesProgress == 7 then
        player:startEvent(10171,0,0,0,0,0,0,0,fellowParam)
    elseif LookingGlass == QUEST_ACCEPTED and LookingGlassProgress == 1 then
        player:startEvent(10040,244,0,0,0,0,0,0,fellowParam)
    else
        player:startEvent(157)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 10171 then
        player:setMaskBit(player:getCharVar("[Quest]Unlisted_Qualities"),"[Quest]Unlisted_Qualities",3,true)
    elseif csid == 10040 then
        player:setCharVar("[Quest]Looking_Glass",2)
    end
end