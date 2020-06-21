-----------------------------------
-- Area: Port Jeuno
--  NPC: Red Ghost
-- Standard Info NPC
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
    {-96.500, 0.000,  8.050},
    {-96.512, 0.000, -8.285},
}

function onSpawn(npc)
    npc:initNpcPathing()
    onPath(npc)
end

function onPath(npc)
    local pos = npc:getPos()
    local point = npc:getPathPoint()
    local dx = path[point][1] - pos.x
    local dz = path[point][3] - pos.z
    local distance = math.sqrt( dx * dx + dz * dz )
    local speed = utils.clamp(250/distance, 10, 15)

    npc:speed(speed)

    tpz.path.pingPong(npc, path, 0)
end

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")
    if (player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatJeuno,15) == false) then
        player:startEvent(314)
        npc:pathStop()
    else
        player:startEvent(34)
        npc:pathStop()
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    if (csid == 314) then
        player:setMaskBit(player:getCharVar("WildcatJeuno"),"WildcatJeuno",15,true)
    end

    npc:pathResume()
end
