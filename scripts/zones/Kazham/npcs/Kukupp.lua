-----------------------------------
-- Area: Kazham
--  NPC: Kukupp
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")

local path =
{
    {44.000, -11.000, -176.000, 0, 0},
    {47.000, -11.000, -179.500, 0, 0},
    {44.000, -11.000, -177.000, 0, 0},
    {40.500, -11.000, -179.500, 0, 0},
    {39.500, -11.000, -176.500, 0, 0},
    {41.300, -11.000, -172.300, 0, 0},
    {45.000, -11.000, -171.300, 0, 0},
    {46.000, -11.000, -173.600, 0, 0},
    {42.700, -11.000, -174.300, 0, 0},
    {44.000, -11.000, -179.800, 0, 0},
}

function onSpawn(npc)
    npc:initNpcPathing(path[1][1], path[1][2], path[1][3])
    onPath(npc)
end

function onPath(npc)
    tpz.path.randomPoint(npc, path, 0)
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
    local goodtrade = trade:hasItemQty(22,1)
    local badtrade = (trade:hasItemQty(483,1) or trade:hasItemQty(1008,1) or trade:hasItemQty(1157,1) or trade:hasItemQty(1158,1) or trade:hasItemQty(904,1) or trade:hasItemQty(4599,1) or trade:hasItemQty(905,1) or trade:hasItemQty(1147,1) or trade:hasItemQty(4600,1))

    if (OpoOpoAndIStatus == QUEST_ACCEPTED) then
        if progress == 1 or failed == 2 then
            if goodtrade then
                player:startEvent(220)
                npc:pathStop()
            elseif badtrade then
                player:startEvent(230)
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
            player:startEvent(198)
            npc:pathStop()
        elseif (progress == 1 or failed == 2) then
                player:startEvent(208)  -- asking for workbench
                npc:pathStop()
        elseif (progress >= 2 or failed >= 3) then
            player:startEvent(243) -- happy with workbench
            npc:pathStop()
        end
    else
        player:startEvent(198)
        npc:pathStop()
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)

    if (csid == 220) then    -- correct trade, onto next opo
        if player:getCharVar("OPO_OPO_PROGRESS") == 1 then
            player:tradeComplete()
            player:setCharVar("OPO_OPO_PROGRESS",2)
            player:setCharVar("OPO_OPO_FAILED",0)
        else
            player:setCharVar("OPO_OPO_FAILED",3)
        end
    elseif (csid == 230) then              -- wrong trade, restart at first opo
        player:setCharVar("OPO_OPO_FAILED",1)
        player:setCharVar("OPO_OPO_RETRY",2)
    end

    npc:pathResume()
end
