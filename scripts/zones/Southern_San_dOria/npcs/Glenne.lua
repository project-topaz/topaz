-------------------------------------
-- Area: Southern San d'Oria
--  NPC: Glenne
-- Starts and Finishes Quest: A Sentry's Peril
-- !pos -122 -2 15 230
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/shop")
require("scripts/globals/quests")
require("scripts/globals/pathfind")

local path =
{
    {-126.185, -2.000, 14.758},
    {-121.511, -2.000, 14.814},
}

function onSpawn(npc)
    npc:initNpcPathing(path[2][1], path[2][2], path[2][3])
    onPath(npc)
end

function onPath(npc)
    tpz.path.pingPong(npc, path, 0)
end

function onTrade(player,npc,trade)
    local count = trade:getItemCount()

    if (player:getQuestStatus(SANDORIA,tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED and
        trade:hasItemQty(532,1) and count == 1) then
            player:messageSpecial(ID.text.FLYER_REFUSED)
    elseif (player:getQuestStatus(SANDORIA,tpz.quest.id.sandoria.A_SENTRY_S_PERIL) == QUEST_ACCEPTED and
        trade:hasItemQty(601,1) and count == 1) then
            player:startEvent(513)
            npc:pathStop()
    end
end

function onTrigger(player,npc)
    local aSentrysPeril = player:getQuestStatus(SANDORIA,tpz.quest.id.sandoria.A_SENTRY_S_PERIL)

    if (aSentrysPeril == QUEST_AVAILABLE) then
        player:startEvent(510)
        npc:pathStop()
    elseif (aSentrysPeril == QUEST_ACCEPTED) then
        if (player:hasItem(600) == true or player:hasItem(601) == true) then
            player:startEvent(520)
            npc:pathStop()
        else
            player:startEvent(644)
            npc:pathStop()
        end
    elseif (aSentrysPeril == QUEST_COMPLETED) then
        player:startEvent(521)
        npc:pathStop()
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    if (csid == 510 and option == 0) then
        if (player:getFreeSlotsCount() > 0) then
            player:addQuest(SANDORIA,tpz.quest.id.sandoria.A_SENTRY_S_PERIL)
            player:addItem(600)
            player:messageSpecial(ID.text.ITEM_OBTAINED,600)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED,600) -- Dose of ointment
        end
    elseif (csid == 644) then
        if (player:getFreeSlotsCount() > 0) then
            player:addItem(600)
            player:messageSpecial(ID.text.ITEM_OBTAINED,600)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED,600) -- Dose of ointment
        end
    elseif (csid == 513) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED,12832) -- Bronze Subligar
        else
            player:tradeComplete()
            player:addTitle(tpz.title.RONFAURIAN_RESCUER)
            player:addItem(12832)
            player:messageSpecial(ID.text.ITEM_OBTAINED,12832) -- Bronze Subligar
            player:addFame(SANDORIA,30)
            player:completeQuest(SANDORIA,tpz.quest.id.sandoria.A_SENTRY_S_PERIL)
        end
    end

    npc:pathResume()
end
