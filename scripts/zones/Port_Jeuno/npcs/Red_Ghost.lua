-----------------------------------
-- Area: Port Jeuno
--  NPC: Red Ghost
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/quests")
-----------------------------------

local path =
{
-97, 0, 8,
-97, 0, 7,
-97, 0, 0,
-97, 0, -7,
-97, 0, -8,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrol(npc, path)
    if npc:isFollowingPath() == false then
        npc:pathThrough(tpz.path.first(path), tpz.path.flag.NONE)
    end
end

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    player:setLocalVar("npcID",npc:getID())
    npc:speed(0) -- Stop Walking to chat
    npc:timer(300000, function(npc) npc:speed(12) end) -- Start walking fallback if event doesnt finish i.e. d/c (5 min)

    local WildcatJeuno = player:getCharVar("WildcatJeuno")
    local FellowQuest = player:getCharVar("[Quest]Unlisted_Qualities")
    if player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatJeuno,15) == false then
        player:startEvent(314)
    elseif player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.UNLISTED_QUALITIES) == QUEST_ACCEPTED and player:getMaskBit(FellowQuest,1) == false then
        player:startEvent(320,0,0,0,0,0,0,0,player:getFellowValue("fellowid"))
    else
        player:startEvent(34)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    if csid == 314 then
        player:setMaskBit(player:getCharVar("WildcatJeuno"),"WildcatJeuno",15,true)
    elseif csid == 320 and option >= 0 and option <= 11 then
        local personality = {4,8,12,16,40,44,20,24,28,32,36,48}
        player:setFellowValue("personality", personality[option+1])
        player:setMaskBit(player:getCharVar("[Quest]Unlisted_Qualities"),"[Quest]Unlisted_Qualities",1,true)
    end
    GetNPCByID(player:getLocalVar("npcID")):speed(12) -- Start Walking again
--[[
Adventuring Fellow Personality Options:
    Male:
        0   Sullen
        1   Passionate
        2   Calm and collected
        3   Serious
        4   Childish
        5   Suave
    Female:
        6   Sisterly
        7   Lively
        8   Agreeable
        9   Naive
        10  Serious
        11  Domineering
--]]
end