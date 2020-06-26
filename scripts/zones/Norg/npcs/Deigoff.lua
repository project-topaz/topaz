-----------------------------------
-- Area: Norg
-- NPC: Deigoff
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind");
-----------------------------------

local path =
{
    {  0.875, -4.885, 30.388, {delay = 5}}, -- top of ramp
    {-12.324, -2.114, 32.669},
    {-16.000, -1.100, 29.000},
    {-18.721,  0.039, 19.500, {delay = 5}}, -- bottom of ramp
    {-16.000, -1.100, 29.000},
    {-11.550, -2.327, 32.669},
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
    player:startEvent(86)
    npc:pathStop()
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    npc:pathResume()
end
