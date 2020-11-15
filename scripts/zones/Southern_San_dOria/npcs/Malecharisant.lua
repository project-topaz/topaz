-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Malecharistant
-- General Info NPC
-------------------------------------
require("scripts/globals/events/harvest_festivals")

function onTrade(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

function onTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
