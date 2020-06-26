-----------------------------------
-- Area: Norg
--  NPC: Oruga
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
    {25.750, -4.900, -14.000},
    {25.170, -5.050, -23.775},
    {20.550, -4.115, -29.890},
    {12.000, -3.213, -31.700},
    { 7.950, -2.950, -31.685},
    {-5.050, -0.690, -31.465},
    { 7.950, -2.950, -31.685},
    {12.000, -3.213, -31.700},
    {20.550, -4.115, -29.890},
    {25.170, -5.050, -23.775},
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
    player:startEvent(87)
    npc:pathStop()
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    npc:pathResume()
end
