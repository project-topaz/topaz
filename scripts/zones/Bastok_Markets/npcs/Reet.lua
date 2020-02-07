-----------------------------------
-- Area: Bastok Markets
--  NPC: Reet
-- Adventurer's Assistant
-- !pos -237 -12 -41 235
-------------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs");
require("scripts/globals/settings");
require("scripts/globals/npc_util")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    local stock =
    {
		4096,	132, 3,	-- Fire Crystal
		4097,	342, 2,	-- Ice Crystal
		4098,	151, 3,	-- Wind Crystal
		4099,	132, 3,	-- Earth Crystal
		4100,	342, 2,	-- Lightning Crystal
		4101,	162, 3,	-- Water Crystal
		4102,	833, 1,	-- Light Crystal
		4103,	747, 1,	-- Dark Crystal
    }

    dsp.shop.nation(player, stock, dsp.nation.BASTOK)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end