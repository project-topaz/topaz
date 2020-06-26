-----------------------------------
-- Area: Norg
--  NPC: Parlemaille
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
    {-20.369, 1.097, -14.000, {delay = 2}},
    {-20.384, 1.097, -29.968, {delay = 2}},
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
    player:startEvent(88)
    npc:pathStop()
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    npc:pathResume()
end
