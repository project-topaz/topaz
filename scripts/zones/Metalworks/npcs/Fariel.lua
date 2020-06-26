-----------------------------------
-- Area: Metalworks
-- NPC: Fariel
-- Type: Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
    {56.000, -14.000, -13.000, {delay = 1}},
    {56.000, -14.000,  14.000, {delay = 1}},
    {37.000, -14.000,  14.000, {delay = 1}},
    {37.000, -14.000, -13.000, {delay = 1}},
}

function onSpawn(npc)
    npc:initNpcPathing(path[1][1], path[1][2], path[1][3])
    onPath(npc)
end

function onPath(npc)
    tpz.path.general(npc, path, tpz.path.flag.WALLHACK, false)
end

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    player:startEvent(706)
    npc:pathStop()
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    npc:pathResume()
end
