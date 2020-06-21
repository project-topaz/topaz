-----------------------------------
-- Area: Kazham
-- NPC: Tatapp
-- Standard Merchant NPC
-----------------------------------
require("scripts/globals/pathfind")

local path =
{
    {15.000,  -8.000, -104.349, 0},
    {16.260,  -8.000, -119.000, 0},
    {16.000, -10.350, -127.260, 0},
    {12.118, -10.630, -141.100, 0},
    {15.210, -10.000, -147.000, 0},
    {24.320, -11.250, -147.880, 0},
    {35.100, -11.000, -149.550, 0},
    {43.380, -11.000, -155.180, 0},
    {55.000, -11.000, -151.000, 0},
    {58.500, -11.250, -144.500, 0},
    {59.700, -11.250, -136.570, 0},
    {67.590, -12.800, -132.000, 0},
    {72.000, -13.235, -127.600, 0},
    {72.000, -14.260, -119.600, 0},
    {75.200, -14.000, -103.800, 0},
    {75.850, -14.220, -100.000, 0},
    {74.880, -13.000,  -95.500, 0},
    {58.520, -12.956,  -95.260, 0},
    {54.000, -12.700,  -88.400, 0},
    {59.370, -11.250,  -75.500, 0},
    {60.200, -11.250,  -67.697, 0},
    {55.000, -11.000,  -64.000, 0},
    {35.000, -11.000,  -64.000, 0},
    {32.500, -11.300,  -67.750, 0},
    {31.735, -10.242,  -72.271, 0},
    {31.800,  -8.000,  -81.500, 0},
    {16.770,  -8.000,  -92.200, 0},
}

function onSpawn(npc)
    npc:initNpcPathing()
    onPath(npc)
end

function onPath(npc)
    tpz.path.basicPath(npc, path, false)
end


function onTrade(player,npc,trade)
    -- item IDs
    -- 483       Broken Mithran Fishing Rod
    -- 22        Workbench
    -- 1008      Ten of Coins
    -- 1157      Sands of Silence
    -- 1158      Wandering Bulb
    -- 904       Giant Fish Bones
    -- 4599      Blackened Toad
    -- 905       Wyvern Skull
    -- 1147      Ancient Salt
    -- 4600      Lucky Egg
    local OpoOpoAndIStatus = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.THE_OPO_OPO_AND_I)
    local progress = player:getCharVar("OPO_OPO_PROGRESS")
    local failed = player:getCharVar("OPO_OPO_FAILED")
    local goodtrade = trade:hasItemQty(4599,1)
    local badtrade = (trade:hasItemQty(483,1) or trade:hasItemQty(22,1) or trade:hasItemQty(1157,1) or trade:hasItemQty(1158,1) or trade:hasItemQty(904,1) or trade:hasItemQty(1008,1) or trade:hasItemQty(905,1) or trade:hasItemQty(1147,1) or trade:hasItemQty(4600,1))

    if (OpoOpoAndIStatus == QUEST_ACCEPTED) then
        if progress == 6 or failed == 7 then
            if goodtrade then
                player:startEvent(225)
                npc:pathStop()
            elseif badtrade then
                player:startEvent(235)
                npc:pathStop()
            end
        end
    end
end

function onTrigger(player,npc)
    local OpoOpoAndIStatus = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.THE_OPO_OPO_AND_I)
    local progress = player:getCharVar("OPO_OPO_PROGRESS")
    local failed = player:getCharVar("OPO_OPO_FAILED")
    local retry = player:getCharVar("OPO_OPO_RETRY")

    if (OpoOpoAndIStatus == QUEST_ACCEPTED) then
        if retry >= 1 then                          -- has failed on future npc so disregard previous successful trade
            player:startEvent(203)
            npc:pathStop()
        elseif (progress == 6 or failed == 7) then
                player:startEvent(212)  -- asking for blackened toad
                npc:pathStop()
        elseif (progress >= 7 or failed >= 8) then
            player:startEvent(248) -- happy with blackened toad
            npc:pathStop()
        end
    else
        player:startEvent(203)
        npc:pathStop()
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)

    if (csid == 225) then    -- correct trade, onto next opo
        if player:getCharVar("OPO_OPO_PROGRESS") == 6 then
            player:tradeComplete()
            player:setCharVar("OPO_OPO_PROGRESS",7)
            player:setCharVar("OPO_OPO_FAILED",0)
        else
            player:setCharVar("OPO_OPO_FAILED",8)
        end
    elseif (csid == 235) then              -- wrong trade, restart at first opo
        player:setCharVar("OPO_OPO_FAILED",1)
        player:setCharVar("OPO_OPO_RETRY",7)
    end

    npc:pathResume()
end
