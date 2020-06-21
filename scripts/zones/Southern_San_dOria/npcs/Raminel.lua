-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Raminel
-- Involved in Quests: Riding on the Clouds
-- !pos -56 2 -21 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/pathfind")
require("scripts/globals/quests")

local path =
{
    {-136.375, -2.000,  18.083, 0, 0, 0}, -- start
    { -99.840, -2.000,  12.070, 0, 0, 0},
    { -91.179,  2.000,   4.392, 0, 0, 0},
    { -64.455,  2.000, -13.255, 0, 0, 0},
    { -13.450,  1.700, -29.180, 0, 4, ID.npc.ARPETION}, -- action house
    { -64.455,  2.000, -13.255, 0, 0, 0},
    { -91.179,  2.000,   4.392, 0, 0, 0},
    { -99.840, -2.000,  12.070, 0, 0, 0},
    {-124.820, -2.000,  17.823, 0, 0, 0},
    {-136.670, -2.000,  14.877, 0, 0, 0},
    {-139.894, -2.000,  14.877, ID.text.RAMINEL_DELIVERY, 4, ID.npc.LUSIANE}, -- at Lusiane
    {-137.169, -2.000,  17.385, 0, 0, 0}, 
}

function onSpawn(npc)
    npc:initNpcPathing(path[1][1], path[1][2], path[1][3])
    onPath(npc)
end

function onPath(npc)
    local pos = npc:getPos()
    local lus = GetNPCByID(ID.npc.LUSIANE)
    local Arp = GetNPCByID(ID.npc.ARPETION)

    -- Arpetion stuff
    if npc:getPathPoint() == 7 then
        Arp:lookAt(pos)
    elseif npc:getPathPoint() == 8 then
        -- when I walk away stop looking at me
        GetNPCByID(ID.npc.LUSIANE):clearTargID()
    end

    -- Lusiane stuff
    if npc:getPathPoint() == 1 then
        if lus:getLocalVar("[THANKYOU_DONE]") == 0 then
            lus:showText(lus, ID.text.LUSIANE_THANK)
            lus:setLocalVar("[THANKYOU_DONE]",1)
        end
        lus:lookAt(pos)
    elseif npc:getPathPoint() == 2 then
        -- when I walk away stop looking at me
        lus:clearTargID()
        lus:setLocalVar("[THANKYOU_DONE]",0)
    end

    -- go back and forth the set path
    tpz.path.advancedPath(npc, path, false)
end

function onTrade(player,npc,trade)
    if (player:getQuestStatus(SANDORIA,tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(532,1) and trade:getItemCount() == 1) then -- Trade Magicmart Flyer
            player:messageSpecial(ID.text.FLYER_REFUSED)
            npc:pathStop()
        end
    end

    if (player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_1") == 1) then
        if (trade:hasItemQty(1127,1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_1",0)
            player:tradeComplete()
            player:addKeyItem(tpz.ki.SCOWLING_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED,tpz.ki.SCOWLING_STONE)
            npc:pathStop()
        end
    end

    npc:pathResume()
end

function onTrigger(player,npc)
    player:startEvent(614)
    npc:pathStop()
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    npc:pathResume()
end
