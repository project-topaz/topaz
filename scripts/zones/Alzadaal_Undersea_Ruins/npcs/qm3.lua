-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: ??? (Spawn Armed Gears(ZNM T3))
-- !pos -42 -4 -169 72
-----------------------------------
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs");

function onTrade(player,npc,trade)
    if (trade:hasItemQty(2574,1) and trade:getItemCount() == 1) then -- Trade Ferrite
        if (not GetMobByID(ID.mob.ARMED_GEARS):isSpawned()) then
            player:tradeComplete();
            SpawnMob(ID.mob.ARMED_GEARS):updateClaim(player);
        end
    end
end;

function onTrade(player,npc,trade)
	if (trade:hasItemQty(18260,1) and trade:getItemCount() == 1) then -- Trade Relic Knuckles
		player:tradeComplete()
		player:addItem(18754)
		player:messageSpecial( ID.text.ITEM_OBTAINED, 18754 )
	end
	if (trade:hasItemQty(18266,1) and trade:getItemCount() == 1) then -- Trade Relic Dagger
		player:tradeComplete()
		player:addItem(19102)
		player:messageSpecial( ID.text.ITEM_OBTAINED, 19102 )
	end
	if (trade:hasItemQty(18326,1) and trade:getItemCount() == 1) then -- Trade Relic Staff
		player:tradeComplete()
		player:addItem(18592)
		player:messageSpecial( ID.text.ITEM_OBTAINED, 18592 )
	end
end;

function onTrigger(player,npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS);
end;
