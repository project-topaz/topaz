-----------------------------------
-- Area: Grauberg [S]
--  NPC:
--  Quest - Seeing Blood-red
-- pos -283 -55 -97
-----------------------------------
local ID = require("scripts/zones/Grauberg_[S]/IDs")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    if player:getCharVar("SeeingBloodRed") == 3 then
        player:startEvent(14)
    end
end

function onEventUpdate(player,csid,option)

end

function onEventFinish(player,csid,option)
    if csid == 14 then
      --player:delKeyItem(tpz.ki.PORTING_MAGIC_TRANSCRIPT)
      --TODO: Teleport player to Ruhotz Silvermines
      --AFTER BCNM:player:setCharVar("SeeingBloodRed",5)
    end
end
