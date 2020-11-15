-----------------------------------
-- Area: Kazham
-- NPC: Bunny in the pen
-- Non interactable NPC
-----------------------------------
require("scripts/globals/pathfind")

local path =
{
    {103.000, -14.000, -100.000},
    {102.000, -14.000, -103.600},
    {101.000, -14.000, -101.000},
    { 97.000, -14.000, -103.500},
    { 97.500, -14.000, -100.000},
    { 95.500, -14.000, -100.000},
}

function onSpawn(npc)
    npc:initNpcPathing(path[1][1], path[1][2], path[1][3])
    onPath(npc)
end

function onPath(npc)
    tpz.path.randomPoint(npc, path, false)
end
