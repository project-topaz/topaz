-----------------------------------
-- Area: Abyssea
-- NPC: Sturdy Pyxis
-----------------------------------
require("scripts/globals/sturdypyxis")
require("scripts/globals/status")
-----------------------------------

function onTrade(player,npc,trade)
    tpz.pyxis.onPyxisTrade(player,npc,trade)
end

function onTrigger(player,npc)
    tpz.pyxis.onPyxisTrigger(player,npc)
end

function onEventUpdate(player,csid,option,input)
    tpz.pyxis.onPyxisEventUpdate(player,csid,option,input)
end

function onEventFinish(player,csid,option,npc)
    tpz.pyxis.onPyxisEventFinish(player,csid,option,npc)
end


