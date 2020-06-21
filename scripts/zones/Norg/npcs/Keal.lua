-----------------------------------
-- Area: Norg
--  NPC: Keal
-- Starts and Ends Quest: It's Not Your Vault
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")

local path =
{
    {-9.856,  0.036,  -9.068, 0},
    {-4.500, -0.037, -18.389, 0},
    {-5.913,  0.107, -27.368, 0},
    {-4.500, -0.037, -18.389, 0},
}

function onSpawn(npc)
    npc:initNpcPathing()
    onPath(npc)
end

function onPath(npc)
    tpz.path.basicPath(npc, path, false)
end

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)

    local Vault = player:getQuestStatus(OUTLANDS,tpz.quest.id.outlands.ITS_NOT_YOUR_VAULT)
    local mLvl = player:getMainLvl()
    local IronBox = player:hasKeyItem(tpz.ki.SEALED_IRON_BOX)

    if (Vault == QUEST_AVAILABLE and player:getFameLevel(NORG) >= 3 and mLvl >= 5) then
        player:startEvent(36,tpz.ki.SEALED_IRON_BOX) -- Start quest
        npc:pathStop()
    elseif (Vault == QUEST_ACCEPTED) then
        if (IronBox == true) then
            player:startEvent(38) -- Finish quest
            npc:pathStop()
        else
            player:startEvent(37,tpz.ki.MAP_OF_THE_SEA_SERPENT_GROTTO) -- Reminder/Directions Dialogue
        end
    elseif (Vault == QUEST_COMPLETED) then
        player:startEvent(39) -- New Standard Dialogue for everyone who has completed the quest
        npc:pathStop()
    else
        player:startEvent(89) -- Standard Conversation
        npc:pathStop()
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    if (csid == 36 and option == 1) then
        player:addQuest(OUTLANDS,tpz.quest.id.outlands.ITS_NOT_YOUR_VAULT)
    elseif (csid == 38) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED,4961)
        else
            player:delKeyItem(tpz.ki.SEALED_IRON_BOX)
            player:addItem(4961) -- Scroll of Tonko: Ichi
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4961)
            player:addFame(NORG,50)
            player:completeQuest(OUTLANDS,tpz.quest.id.outlands.ITS_NOT_YOUR_VAULT)
        end
    end

    npc:pathResume()
end
