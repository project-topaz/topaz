-----------------------------------
-- Area: Kazham
-- NPC: Bunny in the pen
-- Non interactable NPC
-----------------------------------
require("scripts/globals/pathfind")

local path =
{
    {103.800, -14.000,  -99.500, 0, 0},
    {103.400, -14.000, -102.200, 0, 0},
    {101.500, -14.000, -101.000, 0, 0},
    { 98.000, -14.000, -102.500, 0, 0},
    { 97.500, -14.000, -102.000, 0, 0},
    { 95.500, -14.000, -101.000, 0, 0},
}

function onSpawn(npc)
    npc:initNpcPathing(path[1][1], path[1][2], path[1][3])
    onPath(npc)
end

function onPath(npc)
    tpz.path.randomPoint(npc, path, 0)
end
