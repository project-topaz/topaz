-----------------------------------
-- Area: Castle Oztroja
-- NPC: Temp PLD AF NM Spawn
-- !pos -85.7000 -23.7314 -39.9255
-----------------------------------

local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/quests");
require("scripts/globals/settings");
require("scripts/globals/status");
-----------------------------------

function onTrade(player,npc,trade)
    if trade:hasItemQty(17001, 1) and trade:getItemCount() == 1 then -- Trade Giant Shell Bug
        if player:getCharVar("aBoysDreamCS") == 4 and not player:hasItem(4562) then
            player:tradeComplete()
            player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
            local x = player:getXPos()
            local y = player:getYPos()
            local z = player:getZPos()
            local nm = GetMobByID(ID.mob.ODONTOTYRANNUS)
            nm:setSpawn(x,y,z)
            SpawnMob(ID.mob.ODONTOTYRANNUS):updateClaim(player)
        end
    end
end;

function onTrigger(player,npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end;

function onEventUpdate(player,csid,option)
end;
