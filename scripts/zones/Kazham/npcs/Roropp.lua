-----------------------------------
-- Area: Kazham
-- NPC: Roropp
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")

local path =
{
    {16.031, -8.000, -106.132},
    {16.257, -8.000, -105.056},
    {16.488, -8.000, -103.993},
    {16.736, -8.000, -102.925},
    {16.683, -8.000, -103.979},
    {16.548, -8.000, -105.063},
    {16.395, -8.000, -106.140},
    {16.232, -8.000, -107.264},
    {15.467, -8.000, -111.498},
    {14.589, -8.000, -110.994},
    {15.159, -8.000, -111.843},
    {14.467, -8.000, -110.962},
    {15.174, -8.000, -111.862},
    {14.541, -8.000, -111.057},
    {14.902, -8.000, -110.084},
    {16.047, -8.000, -109.979},
    {15.778, -8.000, -111.043},
    {14.890, -8.000, -111.671},
    {14.021, -8.000, -112.251},
    {14.686, -8.000, -111.499},
    {14.093, -8.000, -110.499},
    {13.680, -8.000, -109.391},
    {13.557, -8.000, -108.379},
    {13.505, -8.000, -107.381},
    {13.459, -8.000, -106.253},
    {13.316, -8.000, -103.526},
    {13.187, -8.000, -104.739},
    {13.107, -8.000, -105.800},
    {12.796, -8.000, -112.526},
    {13.832, -8.000, -112.296},
    {14.750, -8.000, -111.783},
    {15.670, -8.000, -111.165},
    {16.603, -8.000, -110.633},
    {16.092, -8.000, -111.518},
    {14.989, -8.000, -111.488},
    {14.200, -8.000, -110.700},
    {13.893, -8.000, -109.573},
    {14.125, -8.000, -108.444},
    {14.459, -8.000, -107.450},
    {14.801, -8.000, -106.489},
    {15.278, -8.000, -101.082},
    {14.444, -8.000, -101.823},
    {13.716, -8.000, -102.551},
    {13.602, -8.000, -103.671},
    {13.773, -8.000, -104.753},
    {14.019, -8.000, -105.842},
    {14.275, -8.000, -106.944},
    {15.256, -8.000, -111.604},
    {14.447, -8.000, -110.851},
    {15.032, -8.000, -111.679},
    {14.342, -8.000, -110.802},
    {13.347, -8.000, -111.075},
    {12.911, -8.000, -112.149},
    {13.853, -8.000, -112.719},
    {14.862, -8.000, -112.491},
    {14.661, -8.000, -111.423},
    {14.026, -8.000, -110.421},
    {13.683, -8.000, -109.474},
    {13.565, -8.000, -108.425},
    {13.508, -8.000, -107.411},
    {13.463, -8.000, -106.340},
    {13.314, -8.000, -103.679},
    {13.196, -8.000, -104.712},
    {13.107, -8.000, -105.817},
    {12.642, -8.000, -112.284},
    {12.722, -8.000, -111.167},
    {12.800, -8.000, -110.082},
    {13.358, -8.000, -103.535},
    {13.700, -8.000, -104.534},
    {13.968, -8.000, -105.588},
    {14.196, -8.000, -106.594},
    {14.446, -8.000, -107.686},
    {14.850, -8.000, -109.436},
    {15.239, -8.000, -111.548},
    {14.406, -8.000, -110.805},
    {15.076, -8.000, -111.739},
    {14.353, -8.000, -110.817},
    {13.903, -8.000, -109.854},
    {14.002, -8.000, -108.838},
    {14.350, -8.000, -107.686},
    {14.707, -8.000, -106.730},
    {15.101, -8.000, -105.648},
    {15.192, -8.000, -101.161},
    {14.369, -8.000, -101.891},
    {13.749, -8.000, -102.797},
    {13.968, -8.000, -103.829},
    {14.469, -8.000, -104.888},
    {14.964, -8.000, -105.802},
    {16.955, -8.000, -109.414},
    {16.776, -8.000, -110.478},
    {16.263, -8.000, -111.339},
    {15.200, -8.000, -111.526},
    {14.352, -8.000, -110.754},
    {15.190, -8.000, -110.001},
    {16.302, -8.000, -110.005},
    {15.815, -8.000, -111.014},
    {14.911, -8.000, -111.661},
    {14.005, -8.000, -112.263},
    {14.883, -8.000, -111.781},
    {14.404, -8.000, -110.876},
    {15.071, -8.000, -111.731},
    {14.335, -8.000, -110.793},
    {13.342, -8.000, -111.184},
    {12.869, -8.000, -112.210},
    {13.971, -8.000, -112.223},
    {14.902, -8.000, -111.661},
    {15.813, -8.000, -111.060},
    {16.728, -8.000, -110.402},
    {16.754, -8.000, -109.357},
    {16.393, -8.000, -108.410},
    {15.880, -8.000, -107.455},
    {15.362, -8.000, -106.521},
    {13.593, -8.000, -103.312},
    {14.028, -8.000, -102.335},
    {14.836, -8.000, -101.487},
    {15.656, -8.000, -100.748},
    {14.859, -8.000, -101.459},
    {13.961, -8.000, -102.255},
    {14.754, -8.000, -101.551},
    {15.574, -8.000, -100.824},
    {15.371, -8.000, -101.005},
    {13.802, -8.000, -102.395},
    {13.852, -8.000, -103.601},
    {14.296, -8.000, -104.610},
    {14.826, -8.000, -105.560},
    {15.320, -8.000, -106.448},
    {15.858, -8.000, -107.421},
    {17.018, -8.000, -109.527},
    {16.734, -8.000, -110.580},
    {16.095, -8.000, -111.542},
}

function onSpawn(npc)
    npc:initNpcPathing(path[1][1], path[1][2], path[1][3])
    onPath(npc)
end

function onPath(npc)
    tpz.path.randomPoint(npc, path, false)
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
    local goodtrade = trade:hasItemQty(1157,1)
    local badtrade = (trade:hasItemQty(483,1) or trade:hasItemQty(22,1) or trade:hasItemQty(1008,1) or trade:hasItemQty(1158,1) or trade:hasItemQty(904,1) or trade:hasItemQty(4599,1) or trade:hasItemQty(905,1) or trade:hasItemQty(1147,1) or trade:hasItemQty(4600,1))

    if (OpoOpoAndIStatus == QUEST_ACCEPTED) then
        if progress == 3 or failed == 4 then
            if goodtrade then
                player:startEvent(222)
                npc:pathStop()
            elseif badtrade then
                player:startEvent(232)
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
            player:startEvent(200)
            npc:pathStop()
        elseif (progress == 3 or failed == 4) then
                player:startEvent(210)  -- asking for sands of silence
                npc:pathStop()
        elseif (progress >= 4 or failed >= 5) then
            player:startEvent(245) -- happy with sands of silence
            npc:pathStop()
        end
    else
        player:startEvent(200)
        npc:pathStop()
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option,npc)

    if (csid == 222) then    -- correct trade, onto next opo
        if player:getCharVar("OPO_OPO_PROGRESS") == 3 then
            player:tradeComplete()
            player:setCharVar("OPO_OPO_PROGRESS",4)
            player:setCharVar("OPO_OPO_FAILED",0)
        else
            player:setCharVar("OPO_OPO_FAILED",5)
        end
    elseif (csid == 232) then              -- wrong trade, restart at first opo
        player:setCharVar("OPO_OPO_FAILED",1)
        player:setCharVar("OPO_OPO_RETRY",4)
    end

    npc:pathResume()
end
