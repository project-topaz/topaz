-----------------------------------
-- Area: Lower Jeuno
--  NPC: Navisse
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
    {-53.714, 6.000, -91.500},
    {-63.367, 6.000, -86.700},
    {-58.000, 6.000, -94.770},
    {-53.500, 6.000, -87.632},
    {-61.099, 6.000, -89.034},
    {-61.841, 6.000, -88.238},
    {-60.796, 6.000, -88.208},
    {-56.590, 6.000, -91.245}
}

function onSpawn(npc)
    npc:initNpcPathing(path[1][1], path[1][2], path[1][3])
    onPath(npc)
end

function onPath(npc)
    tpz.path.randomPoint(npc, path, false)
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
