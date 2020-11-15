-----------------------------------
-- Area: Norg
--  NPC: Louartain
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
    {42.200, -6.282223,  7.717, {delay = 6}},
    {41.570, -6.282223, 18.748, {delay = 6}},
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
    player:startEvent(84)
    npc:pathStop()
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    npc:pathResume()
end
