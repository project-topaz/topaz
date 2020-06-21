-----------------------------------
-- Area: Kazham
-- NPC: Lulupp
-- Type: Standard NPC
-- !pos -26.567 -3.5 -3.544 250
-----------------------------------
require("scripts/globals/pathfind")

local path =
{
    {-27.000, -3.300, -23.000, 5},
    {-27.000, -2.500, -18.500, 0},
    {-27.000, -2.500,  -9.000, 0},
    {-27.000, -2.500,   2.000, 5},
    {-27.000, -2.500,  -9.000, 0},
    {-27.000, -2.500, -18.500, 0},
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
    local goodtrade = trade:hasItemQty(483,1)
    local badtrade = (trade:hasItemQty(22,1) or trade:hasItemQty(1008,1) or trade:hasItemQty(1157,1) or trade:hasItemQty(1158,1) or trade:hasItemQty(904,1) or trade:hasItemQty(4599,1) or trade:hasItemQty(905,1) or trade:hasItemQty(1147,1) or trade:hasItemQty(4600,1))

    if (OpoOpoAndIStatus == QUEST_ACCEPTED) then
        if progress == 0 or failed == 1 then
            if goodtrade then                   -- first or second time trading correctly
                player:startEvent(219)
                npc:pathStop()
            elseif badtrade then
                player:startEvent(229)
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

    npc:pathStop()

    if (player:getCharVar("BathedInScent") == 1 and OpoOpoAndIStatus == QUEST_AVAILABLE) then
        player:startEvent(217, 0, 483)  -- 483 broken mithran fishing rod
        npc:pathStop()
    elseif (OpoOpoAndIStatus == QUEST_ACCEPTED) then
        if retry == 1 then
            player:startEvent(239) -- gave 1st NPC wrong item instead of "Broken Mithran Fishing Rod"
            npc:pathStop()
        elseif retry == 2 then
            player:startEvent(239, 0, 0, 1) -- gave 2nd NPC wrong item instead of "Workbench"
            npc:pathStop()
        elseif retry == 3 then
            player:startEvent(239, 0, 0, 2) -- gave 3rd NPC wrong item instead of "Ten of Coins"
            npc:pathStop()
        elseif retry == 4 then
            player:startEvent(239, 0, 0, 3) -- gave 4th NPC wrong item instead of "Sands of silence"
            npc:pathStop()
        elseif retry == 5 then
            player:startEvent(239, 0, 0, 4) -- gave 5th NPC wrong item instead of "Wandering Bulb"
            npc:pathStop()
        elseif retry == 6 then
            player:startEvent(239, 0, 0, 5) -- gave 6th NPC wrong item instead of "Giant Fish Bones"
            npc:pathStop()
        elseif retry == 7 then
            player:startEvent(239, 0, 0, 6) -- gave 7th NPC wrong item instead of "Blackened Toad"
            npc:pathStop()
        elseif retry == 8 then
            player:startEvent(239, 0, 0, 7) -- gave 8th NPC wrong item instead of "Wyvern Skull"
            npc:pathStop()
        elseif retry == 9 then
            player:startEvent(239, 0, 0, 8) -- gave 9th NPC wrong item instead of "Ancient Salt"
            npc:pathStop()
        elseif retry == 10 then
            player:startEvent(239, 0, 0, 9) -- gave 10th NPC wrong item instead of "Lucky Egg" ... uwot
            npc:pathStop()
        elseif (progress == 0 or failed == 1) then
            player:startEvent(207)  -- asking for rod with Opoppo
            npc:pathStop()
        elseif (progress >= 1 or failed >= 2) then
            player:startEvent(242) -- happy with rod
            npc:pathStop()
        end
    else
        player:startEvent(197)  -- not sure why but this cs has no text
        npc:pathStop()
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)
    if (csid == 217 and option == 1)  then                   -- Opo Opo and I quest start CS
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.THE_OPO_OPO_AND_I)
    elseif (csid == 219) then
        if (player:getCharVar("OPO_OPO_PROGRESS") == 0) then
            player:tradeComplete();
            player:setCharVar("OPO_OPO_PROGRESS",1)
        else
            player:setCharVar("OPO_OPO_FAILED",2)
        end
    elseif (csid == 229) then                                -- Traded wrong item, saving current progress to not take item up to this point
        player:setCharVar("OPO_OPO_RETRY",1)
    elseif (csid == 239 and option == 1) then                -- Traded wrong to another NPC, give a clue
        player:setCharVar("OPO_OPO_RETRY",0)
        player:setCharVar("OPO_OPO_FAILED",1)
    end

    npc:pathResume()
end
