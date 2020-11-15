-----------------------------------
-- Area: Windurst Walls (239)
--  NPC: Greeter Moogle
-- !pos NEED POS
-----------------------------------
require("scripts/globals/events/login_campaign")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.events.loginCampaign.onTrigger(player)
end

function onEventUpdate(player, csid, option)
    tpz.events.loginCampaign.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
