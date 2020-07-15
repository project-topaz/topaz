-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: ??? (Spawn Cheese Hoarder Gigiroon(ZNM T1))
-- !pos -184 -8 24 72
-----------------------------------
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player,npc,trade)
    if npcUtil.tradeHas(trade, 2582) and npcUtil.popFromQM(player, npc, ID.mob.CHEESE_HOARDER_GIGIROON) then
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end;

function onTrade(player,npc,trade)
	if (trade:hasItemQty(18326,1) and trade:getItemCount() == 1) then -- Trade Relic Staff
		player:tradeComplete();
		player:addItem(18590);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 18590 )
	end
end;

function onTrigger(player,npc)
    player:messageSpecial(ID.text.HEADY_FRAGRANCE)
end;
