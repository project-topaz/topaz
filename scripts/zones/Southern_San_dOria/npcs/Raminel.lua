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
    {-136.375, -2.000,  18.083}, -- start
    { -99.840, -2.000,  12.070},
    { -91.179,  2.000,   4.392},
    { -64.455,  2.000, -13.255},
    { -13.450,  1.700, -29.180, {rot = 25}}, -- action house
    { -64.455,  2.000, -13.255},
    { -91.179,  2.000,   4.392},
    { -99.840, -2.000,  12.070},
    {-124.820, -2.000,  17.823},
    {-136.670, -2.000,  14.877},
    {-140.194, -2.000,  14.721, {rot = 124}}, -- at Lusiane
    {-139.494, -2.000,  16.355},
    {-137.169, -2.000,  17.385}, 
}

function onSpawn(npc)
    npc:initNpcPathing(path[1][1], path[1][2], path[1][3])
    onPath(npc)
end

function onPath(npc)
    local pos = npc:getPos()
    local point = npc:getPathPoint()
    local Lus = GetNPCByID(ID.npc.LUSIANE)
    local Arp = GetNPCByID(ID.npc.ARPETION)

    -- Arpetion stuff
    if point == 5 then
        Arp:lookAt(pos)
    elseif point == 6 then
        if npc:getLocalVar("[SPEECH_DONE]") == 0 then
            npc:showText(npc, ID.text.RAMINEL_DELIVERY)
            npc:setLocalVar("[SPEECH_DONE]",1)
        end 
    elseif point == 7 then
        -- when I walk away stop looking at me
        Arp:clearTargID()
        npc:setLocalVar("[SPEECH_DONE]",0)
    end

    -- Lusiane stuff
    if point == 12 then
        Lus:lookAt(pos)
        if npc:getLocalVar("[SPEECH_DONE]") == 0 then
            npc:showText(npc, ID.text.RAMINEL_DELIVERY)
            npc:setLocalVar("[SPEECH_DONE]",1)
        end
    elseif point == 13 then
        if Lus:getLocalVar("[SPEECH_DONE]") == 0 then
            Lus:showText(Lus, ID.text.LUSIANE_THANK)
            Lus:setLocalVar("[SPEECH_DONE]",1)
        end
    elseif point == 1 then
        -- when I walk away stop looking at me
        Lus:clearTargID()
        Lus:setLocalVar("[SPEECH_DONE]",0)
    end

    -- go back and forth the set path
    tpz.path.general(npc, path, tpz.path.flag.NONE, false)
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
