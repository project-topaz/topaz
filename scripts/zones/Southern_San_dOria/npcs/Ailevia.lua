-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ailevia
-- Adventurer's Assistant
-- Only recieving Adv.Coupon and simple talk event are scripted
-- This NPC participates in Quests and Missions
-- !pos -8 1 1 230
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs");
require("scripts/globals/settings");
require("scripts/globals/quests");
require("scripts/globals/shop");
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player,npc,trade)
    -- Adventurer coupon
    if (trade:getItemCount() == 1 and trade:hasItemQty(536,1) == true) then
        player:startEvent(655);
    end
    -- "Flyers for Regine" conditional script
    local count = trade:getItemCount();
    local MagicFlyer = trade:hasItemQty(532,1);

    if (MagicFlyer == true and count == 1) then
        local FlyerForRegine = player:getQuestStatus(SANDORIA,dsp.quest.id.sandoria.FLYERS_FOR_REGINE);
        if (FlyerForRegine == 1) then
            player:messageSpecial(ID.text.FLYER_REFUSED);
        end
    end
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

    dsp.shop.nation(player, stock, dsp.nation.SANDORIA)
--    player:startEvent(615); -- i know a thing or 2 about these streets
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;
