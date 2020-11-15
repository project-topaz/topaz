-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Lotte
-- General Info NPC
-------------------------------------
require("scripts/globals/events/harvest_festivals")

function onTrade(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

function onTrigger(player, npc)
    player:startEvent(564)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
