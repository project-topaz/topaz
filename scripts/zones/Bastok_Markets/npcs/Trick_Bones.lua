-----------------------------------
-- Area: Bastok_Markets
--  NPC: Trick Bones
-- Used for Havrest Festival
-- Wanders zone
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/zone")
require("scripts/globals/pathfind")
-----------------------------------

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.random(events.harvest.paths.bastok))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrol(npc, events.harvest.paths.bastok)
end


function onTrigger(player, npc)
    player:messageSpecial(ID.text.TRICK_OR_TREAT)
end

function onTrade(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end
