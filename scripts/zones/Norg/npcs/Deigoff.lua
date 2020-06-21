-----------------------------------
-- Area: Norg
-- NPC: Deigoff
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind");
-----------------------------------

local path =
{
    {  0.875, -4.885, 30.388, 5},
    {-16.000, -1.100, 29.000, 0},
    {-18.721,  0.039, 19.500, 5},
    {-16.000, -1.100, 29.000, 0},
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
    player:startEvent(86)
    npc:pathStop()
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    npc:pathResume()
end
