-----------------------------------
-- Area: Norg
--  NPC: Paito-Maito
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
    {-68.950, -9.448, 72.590},
    {-73.000, -9.256, 72.037},
    {-75.900, -9.023, 70.197},
    {-84.900, -9.256, 73.033},
    {-75.320, -9.386, 76.639},
}

function onSpawn(npc)
    npc:initNpcPathing()
    onPath(npc)
end

function onPath(npc)
    tpz.path.general(npc, path, tpz.path.flag.WALLHACK, false)
end

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    player:startEvent(90);
    npc:pathStop()
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    npc:pathResume()
end
