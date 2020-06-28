-----------------------------------
-- Area: Kazham
--  NPC: Thali Mhobrum
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")

local path =
{
    {56.000, -11.000, -44.000, {delay = 5}},
    {52.000, -11.000, -44.000},
    {47.000, -11.000, -44.000, {delay = 5}},
    {52.000, -11.000, -44.000},
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
    if (player:getCharVar("BathedInScent") == 1) then
        player:startEvent(163) -- scent from Blue Rafflesias
        npc:pathStop()
    else
        player:startEvent(190)
        npc:pathStop()
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    npc:pathResume()
end
