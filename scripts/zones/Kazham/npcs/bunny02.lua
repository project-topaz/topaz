-----------------------------------
-- Area: Kazham
-- NPC: Bunny in the pen
-- Non interactable NPC
-----------------------------------
require("scripts/globals/pathfind")

local path =
{
    {103.500, -14.000,  -99.500},
    {103.800, -14.000, -101.600},
    {101.400, -14.000, -100.000},
    { 99.000, -14.000, -101.700},
    { 97.200, -14.000, -101.800},
    { 95.500, -14.000, -100.000},
}

function onSpawn(npc)
    npc:initNpcPathing(path[1][1], path[1][2], path[1][3])
    onPath(npc)
end

function onPath(npc)
    tpz.path.randomPoint(npc, path, false)
end
