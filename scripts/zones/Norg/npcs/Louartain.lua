-----------------------------------
-- Area: Norg
--  NPC: Louartain
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
    {42.200, -6.282223,  7.717, 6},
    {41.570, -6.282223, 18.748, 6},
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
    player:startEvent(84)
    npc:pathStop()
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    npc:pathResume()
end
