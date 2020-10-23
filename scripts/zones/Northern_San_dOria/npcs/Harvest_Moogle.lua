-----------------------------------
-- Area: Northern San dOria
-- NPC:Moogle
-- ID:17723811
-- !pos -222.8 8 79 231
-----------------------------------
require("scripts/globals/shop")
local ID = require("scripts/zones/Northern_San_dOria/IDs")

function onTrade(player, npc, trade)

end

function onTrigger(player, npc)
    local stock =
    {
        4488, 1000, --Jack o Lantern
         203, 5000, --Bomb Lantern
         204, 5000, --Pumpkin Lantern
         205, 5000, --Mandra Lantern
        3622,10000, --Jack-o'-Pricket
    }
    player:showText(npc, ID.text.MOOGLE_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)

end

function onEventFinish(player, csid, option)

end
