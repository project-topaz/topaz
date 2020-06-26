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
    {20.600, -0.343, -23.000, {delay = 5}},
    {35.431, -0.045, -20.227},
    {51.795, -1.790, -18.843},
    {58.037, -0.957, -18.724},
    {65.919, -1.722, -18.767},
    {92.143, -0.451, -16.231, {delay = 5}},
    {65.919, -1.722, -18.767},
    {58.037, -0.957, -18.724},
    {51.795, -1.790, -18.843},
    {35.431, -0.045, -20.227},
}

function onSpawn(npc)
    npc:initNpcPathing()
    onPath(npc)
end

function onPath(npc)
    tpz.path.general(npc, path, tpz.path.flag.WALLHACK, false)
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.INFILTRATE_DAVOI and player:getCharVar("MissionStatus") == 3) then
        player:startEvent(117)
        npc:pathStop()
    else
        player:showText(npc, ID.text.QUEMARICOND_DIALOG)
        npc:clearTargID()
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
