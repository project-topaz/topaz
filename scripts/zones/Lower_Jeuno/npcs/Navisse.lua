-----------------------------------
-- Area: Lower Jeuno
--  NPC: Navisse
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
    {-53.714, 6.000, -91.500, 25,  0},
    {-63.367, 6.000, -86.700, 150, 0},
    {-58.000, 6.000, -94.770,   0, 0},
    {-53.500, 6.000, -87.632,   0, 0},
    {-61.099, 6.000, -89.034,   0, 0},
    {-61.841, 6.000, -88.238,   0, 0},
    {-60.796, 6.000, -88.208,   0, 0},
    {-56.590, 6.000, -91.245,   0, 0}
}

function onSpawn(npc)
    npc:initNpcPathing(path[1][1], path[1][2], path[1][3])
    onPath(npc)
end

function onPath(npc)
    tpz.path.randomPoint(npc, path, 0)
end

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    player:startEvent(153)
    npc:pathStop()
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    npc:pathResume()
end
