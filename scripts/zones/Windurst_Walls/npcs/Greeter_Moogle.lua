-----------------------------------
-- Area: Windurst Walls (239)
--  NPC: Greeter Moogle
-- !pos NEED POS
-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/wsquest")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
require("scripts/globals/logincampaign")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.logincampaign.check(player)
end

function onEventUpdate(player, csid, option)
    tpz.logincampaign.eventupdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
