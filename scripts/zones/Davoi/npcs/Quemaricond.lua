-----------------------------------
-- Area: Davoi
--  NPC: Quemaricond
-- Involved in Mission: Infiltrate Davoi
-- !pos 23 0.1 -23 149
-----------------------------------
local ID = require("scripts/zones/Davoi/IDs")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
    {20.600,  0.000, -23.000, 0, 5, 0},
    {50.000, -1.500, -19.000, 0, 0, 0},
    {53.500, -1.800, -19.000, 0, 0, 0},
    {58.000, -1.000, -19.000, 0, 0, 0},
    {65.500, -1.800, -19.000, 0, 0, 0},
    {91.000, -0.500, -16.500, 0, 5, 0},
    {65.500, -1.800, -19.000, 0, 0, 0},
    {58.000, -1.000, -19.000, 0, 0, 0},
    {53.500, -1.800, -19.000, 0, 0, 0},
    {50.000, -1.500, -19.000, 0, 0, 0},
}

function onSpawn(npc)
    npc:initNpcPathing()
    onPath(npc)
end

function onPath(npc)
    tpz.path.advancedPath(npc, path, false)
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.INFILTRATE_DAVOI and player:getCharVar("MissionStatus") == 3) then
        player:startEvent(117)
        npc:pathStop()
    else
        player:showText(npc, ID.text.QUEMARICOND_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    if (csid == 117) then
        player:setCharVar("MissionStatus",4)
        player:addKeyItem(tpz.ki.ROYAL_KNIGHTS_DAVOI_REPORT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED,tpz.ki.ROYAL_KNIGHTS_DAVOI_REPORT)
    end

    npc:pathResume()
end
