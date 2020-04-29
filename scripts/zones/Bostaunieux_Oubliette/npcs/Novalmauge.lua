-----------------------------------
-- Area: Bostaunieux Obliette
-- NPC: Novalmauge
-- Starts and Finishes Quest: The Rumor, Souls in Shadow
-- Involved in Quest: The Holy Crest, Trouble at the Sluice
-- !pos 70 -24 21 167
-----------------------------------
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/pathfind")
require("scripts/globals/wsquest")
require("scripts/globals/quests")
-----------------------------------

local path =
{
    [1] = {20.000, -24.000, 20.000, 0},
    [2] = {50.000, -24.000, 20.000, 0},
    [3] = {75.000, -24.000, 20.000, 0},
    [2] = {50.000, -24.000, 20.000, 0}
}

local wsQuest = tpz.wsquest.spiral_hell

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(path[1][1], path[1][2], path[1][3], 0)
    npc:speed(12)
    npc:setPathPoint(1)
    onPath(npc)
end

function onPath(npc)
    tpz.path.npcBasicPath(npc, path, 0)
end

function onTrade(player, npc, trade)
    local wsQuestEvent = tpz.wsquest.getTradeEvent(wsQuest, player, trade)
    
    if player:getCharVar("troubleAtTheSluiceVar") == 2 and npcUtil.tradeHas(trade, 959) then -- Dahlia
        player:startEvent(17)
        npc:speed(0)
    elseif player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_RUMOR) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 930) then -- Beastman Blood
        player:startEvent(12)
        npc:speed(0)
    elseif wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
        npc:speed(0)
    end
end

function onTrigger(player, npc)
    local wsQuestEvent = tpz.wsquest.getTriggerEvent(wsQuest, player)
    local troubleAtTheSluice = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.TROUBLE_AT_THE_SLUICE)
    local troubleAtTheSluiceStat = player:getCharVar("troubleAtTheSluiceVar")
    local theHolyCrestStat = player:getCharVar("TheHolyCrest_Event")
    local theRumor = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_RUMOR)

    npc:speed(0)

    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)

    -- THE HOLY CREST
    elseif theHolyCrestStat == 1 then
        player:startEvent(6)
    elseif theHolyCrestStat == 2 and player:getCharVar("theHolyCrestCheck") == 0 then
        player:startEvent(7)

    -- TROUBLE AT THE SLUICE
    elseif troubleAtTheSluiceStat == 1 then
        player:startEvent(15)
    elseif troubleAtTheSluiceStat == 2 then
        player:startEvent(16)

    -- THE RUMOR
    elseif theRumor == QUEST_AVAILABLE and player:getFameLevel(SANDORIA) >= 3 and player:getMainLvl() >= 10 then
        player:startEvent(13)
    elseif theRumor == QUEST_ACCEPTED then
        player:startEvent(11)
    elseif theRumor == QUEST_COMPLETED then
        player:startEvent(14) -- Standard dialog after "The Rumor"
    else
        player:startEvent(10) -- Standard dialog
    end
end

function onEventFinish(player, csid, option, npc)
    if csid == 6 then
        player:setCharVar("TheHolyCrest_Event", 2)
    elseif csid == 7 then
        player:setCharVar("theHolyCrestCheck", 1)
    elseif csid == 12 and npcUtil.completeQuest(player, SANDORIA, tpz.quest.id.sandoria.THE_RUMOR, {item = 4853}) then
        player:confirmTrade()
    elseif csid == 13 and option == 1 then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.THE_RUMOR)
    elseif csid == 14 then
        player:setCharVar("theHolyCrestCheck", 0)
    elseif csid == 15 then
        player:setCharVar("troubleAtTheSluiceVar", 2)
    elseif csid == 17 then
        npcUtil.giveKeyItem(player, tpz.ki.NEUTRALIZER)
        player:setCharVar("troubleAtTheSluiceVar", 0)
        player:setCharVar("theHolyCrestCheck", 0)
        player:confirmTrade()
    else
        tpz.wsquest.handleEventFinish(wsQuest, player, csid, option, ID.text.SPIRAL_HELL_LEARNED)
    end

    npc:speed(12)
    tpz.path.npcBasicPath(npc, path, 0)
end
