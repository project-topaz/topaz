-----------------------------------
-- Area: Port San d'Oria
--  NPC: Portaure
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/pets/fellow")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player,npc,trade)
    if player:getQuestStatus(SANDORIA,tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED then
        if trade:hasItemQty(532,1) and trade:getItemCount() == 1 and player:getCharVar("tradePortaure") == 0 then
            player:messageSpecial(ID.text.PORTAURE_DIALOG)
            player:setCharVar("FFR",player:getCharVar("FFR") - 1)
            player:setCharVar("tradePortaure",1)
            player:messageSpecial(ID.text.FLYER_ACCEPTED)
            player:messageSpecial(ID.text.FLYERS_HANDED,17 - player:getCharVar("FFR"))
            player:tradeComplete()
        elseif (player:getCharVar("tradePortaure") ==1) then
            player:messageSpecial(ID.text.FLYER_ALREADY)
        end
    end
end

function onTrigger(player,npc)
    local MirrorMirror = player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.MIRROR_MIRROR)
    local MirrorMirrorProgress = player:getCharVar("[Quest]Mirror_Mirror")
    local fellowParam = getFellowParam(player)

    if MirrorMirror == QUEST_ACCEPTED and MirrorMirrorProgress == 1 then
        player:startEvent(745,0,0,0,0,0,0,0,fellowParam)
    else
        player:startEvent(650) -- 651 starts quest "A Job For The Consortium"
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 745 then
        player:setCharVar("[Quest]Mirror_Mirror", 2)
    end
end
