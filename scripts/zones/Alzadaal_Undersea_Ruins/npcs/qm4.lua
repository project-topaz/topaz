-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: ??? (Spawn Wulgaru(ZNM T2))
-- !pos -22 -4 204 72
-----------------------------------
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs");

function onTrade(player,npc,trade)
    if (trade:hasItemQty(2597,1) and trade:getItemCount() == 1) then -- Trade Opalus Gem
        if (not GetMobByID(ID.mob.WULGARU):isSpawned()) then
            player:tradeComplete();
            SpawnMob(ID.mob.WULGARU):updateClaim(player);
        end
	end
end;

function onTrade(player,npc,trade)
	if (trade:hasItemQty(18290,1) and trade:getItemCount() == 1) then -- Trade Relic Bhuj
		player:tradeComplete();
		player:addItem(18492);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 18492 )
	end
	if (trade:hasItemQty(18260,1) and trade:getItemCount() == 1) then -- Trade Relic Knuckles
		player:tradeComplete();
		player:addItem(18753);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 18753 )
	end
	if (trade:hasItemQty(18320,1) and trade:getItemCount() == 1) then -- Trade Relic Maul
		player:tradeComplete();
		player:addItem(18851);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 18851 )
	end
	if (trade:hasItemQty(18326,1) and trade:getItemCount() == 1) then -- Trade Relic Staff
		player:tradeComplete();
		player:addItem(18589);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 18589 )
	end
	if (trade:hasItemQty(18272,1) and trade:getItemCount() == 1) then -- Trade Relic Sword
		player:tradeComplete();
		player:addItem(17742);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 17742 )
	end
	if (trade:hasItemQty(18266,1) and trade:getItemCount() == 1) then -- Trade Relic Dagger
		player:tradeComplete();
		player:addItem(18003);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 18003 )
	end
	if (trade:hasItemQty(15066,1) and trade:getItemCount() == 1) then -- Trade Relic Shield
		player:tradeComplete();
		player:addItem(17744);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 17744 )
	end
	if (trade:hasItemQty(18302,1) and trade:getItemCount() == 1) then -- Trade Relic Scythe
		player:tradeComplete();
		player:addItem(18944);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 18944 )
	end
	if (trade:hasItemQty(18284,1) and trade:getItemCount() == 1) then -- Trade Relic Axe
		player:tradeComplete();
		player:addItem(17956);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 17956 )
	end
	if (trade:hasItemQty(18338,1) and trade:getItemCount() == 1) then -- Trade Relic Horn
		player:tradeComplete();
		player:addItem(18034);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 18034 )
	end
	if (trade:hasItemQty(18344,1) and trade:getItemCount() == 1) then -- Trade Relic Bow
		player:tradeComplete();
		player:addItem(18719);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 18719 )
	end
	if (trade:hasItemQty(18314,1) and trade:getItemCount() == 1) then -- Trade Ito
		player:tradeComplete();
		player:addItem(18443);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 18443 )
	end
	if (trade:hasItemQty(18308,1) and trade:getItemCount() == 1) then -- Trade Ihintanto
		player:tradeComplete();
		player:addItem(18426);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 18426 )
	end
	if (trade:hasItemQty(18296,1) and trade:getItemCount() == 1) then -- Trade Relic Lance
		player:tradeComplete();
		player:addItem(18120);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 18120 )
	end
	if (trade:hasItemQty(18278,1) and trade:getItemCount() == 1) then -- Trade Relic Blade
		player:tradeComplete();
		player:addItem(17743);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 17743 )
	end
	if (trade:hasItemQty(18332,1) and trade:getItemCount() == 1) then -- Trade Relic Gun
		player:tradeComplete();
		player:addItem(18720);
		player:messageSpecial( ID.text.ITEM_OBTAINED, 18720 )
	end
end;

function onTrigger(player,npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS);
end;