-----------------------------------
-- Area: Lower Jeuno
--  NPC: Vhana Ehgaklywha
-- Lights lamps in Lower Jeuno if nobody accepts Community Service by 1AM.
-- !pos -122.853 0.000 -195.605 245
-----------------------------------
require("scripts/zones/Lower_Jeuno/globals")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/status")
-----------------------------------

function onSpawn(npc)
    if VanadielHour() ~= 1 then
        if npc:getStatus() == tpz.status.NORMAL then
            npc:setStatus(tpz.status.DISAPPEAR)
        end
    end
    npc:pathStop()
end

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    player:showText(npc, ID.text.VHANA_TEXT)
    npc:clearTargID()
end

function onPath(npc)
    local point = npc:getPathPoint()

    if npc:getStatus() == tpz.status.NORMAL then
        -- if vasha reaches the end node, halt and disappear her.
        if point == #LOWER_JEUNO.lampPath then
            npc:clearPath()
            npc:setStatus(tpz.status.DISAPPEAR)
            npc:pathStop()
        else
            -- if vasha is at one of the lamp points, turn on that lamp.
            -- she reaches the lamps in reverse order of their npcIds, hence (12 - i).
            for i = 1, #LOWER_JEUNO.lampPoints do
                if LOWER_JEUNO.lampPoints[i] == point then
                    local lamp = GetNPCByID(ID.npc.STREETLAMP_OFFSET + (12 -i))
                    lamp:setAnimation(tpz.anim.OPEN_DOOR)
                    break
                end
            end
        end
        tpz.path.advancedPath(npc, LOWER_JEUNO.lampPath, false)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    npc:pathResume()
end
