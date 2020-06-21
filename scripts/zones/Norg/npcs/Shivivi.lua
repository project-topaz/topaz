-----------------------------------
-- Area: Norg
--  NPC: Shivivi
-- Starts Quest: Secret of the Damp Scroll
-- !pos 68.729 -6.281 -6.432 252
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
require("scripts/globals/quests")
require("scripts/globals/pathfind")

local path =
{
    {48.240, -6.282,  1.750, 2},
    {55.292, -6.282,  1.055, 0},
    {66.858, -6.282, -5.389, 0},
    {73.660, -6.282, -9.417, 2},
    {66.858, -6.282, -5.389, 0},
    {55.292, -6.282,  1.055, 0},
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
    DampScroll = player:getQuestStatus(OUTLANDS,tpz.quest.id.outlands.SECRET_OF_THE_DAMP_SCROLL)
    mLvl = player:getMainLvl()

    if (DampScroll == QUEST_AVAILABLE and player:getFameLevel(NORG) >= 3 and mLvl >= 10 and player:hasItem(1210) == true) then
        player:startEvent(31,1210) -- Start the quest
        npc:pathStop()
    elseif (DampScroll == QUEST_ACCEPTED) then
        player:startEvent(32) -- Reminder Dialogue
        npc:pathStop()
    else
        player:startEvent(85)
        npc:pathStop()
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    if (csid == 31) then
        player:addQuest(OUTLANDS,tpz.quest.id.outlands.SECRET_OF_THE_DAMP_SCROLL)
    end

    npc:pathResume()
end
