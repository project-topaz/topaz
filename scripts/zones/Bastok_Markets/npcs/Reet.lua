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
		4096,	102, 3,	-- Fire Crystal
		4097,	307, 2,	-- Ice Crystal
		4098,	99,  3,	-- Wind Crystal
		4099,	102, 3,	-- Earth Crystal
		4100,	307, 2,	-- Lightning Crystal
		4101,	116, 3,	-- Water Crystal
		4102,	718, 1,	-- Light Crystal
		4103,	589, 1,	-- Dark Crystal
        1255, 12324, 2, -- Fire Ore
        1256, 12324, 2, -- Ice Ore
        1257, 12324, 2, -- Wind Ore
        1258, 12324, 2, -- Earth Ore
        1259, 12324, 2, -- Lightning Ore
        1260, 12324, 2, -- Water Ore
        1261, 12324, 2, -- Light Ore
        1262, 12324, 2, -- Dark Ore
    }

    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end