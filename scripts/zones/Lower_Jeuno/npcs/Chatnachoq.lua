-----------------------------------
-- Area: Lower Jeuno
--  NPC: Chatnachoq
-- Standard Info NPC
-----------------------------------
require("scripts/globals/settings");
require("scripts/globals/shop");
require("scripts/globals/keyitems");
local ID = require("scripts/zones/Lower_Jeuno/IDs");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    --player:startEvent(10095);
    local stock =
    {
        --10049, 25000, -- ♪Raptor
        10050, 25000, -- ♪Tiger
        10051, 25000, -- ♪Crab
    }

    player:showText(npc, ID.text.ADELFLETE_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;
