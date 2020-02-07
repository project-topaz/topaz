-----------------------------------
-- Area: Bastok Mines
--  NPC: Arva
-- Adventurer's Assistant
-- Working 100%
-------------------------------------
require("scripts/globals/settings");
local ID = require("scripts/zones/Bastok_Mines/IDs");
require("scripts/globals/npc_util")
require("scripts/globals/shop")

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if (csid == 4) then
        player:messageSpecial(ID.text.GIL_OBTAINED,GIL_RATE*50);
    end
end
