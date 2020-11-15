-----------------------------------
-- Area: Windurst Waters
-- NPC:Moogle
-- ID:17752545
-- !pos -12.140 -1.000 28.499 238
-----------------------------------
require("scripts/globals/shop")
local ID = require("scripts/zones/Windurst_Woods/IDs")

function onTrade(player, npc, trade)

end

function onTrigger(player, npc)
    local stock =
    {
        4488, 1000, --Jack o Lantern
         203, 5000, --Bomb Lantern
         204, 5000, --Pumpkin Lantern
         205, 5000, --Mandra Lantern
        3646,10000, --Mandra. Pricket

    }
    player:showText(npc, ID.text.MOOGLE_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)

end

function onEventFinish(player, csid, option)

end
