------------------------------------
-- Transport
------------------------------------
require("scripts/globals/zone")
require("scripts/globals/pathfind")
------------------------------------

tpz = tpz or {}
tpz.transport = tpz.transport or {}

tpz.transport.message =
{
    NEARING = 0,
    DOCKING = 1
}

tpz.transport.epochOffset =
{
    NEARING = 265,
    DOCKING = 290
}

tpz.transport.messageTime =
{
    SILVER_SEA = 480
}

tpz.transport.trigger =
{
    mhaura =
    {
        FERRY_ARRIVING_FROM_ALZAHBI = 0,
        FERRY_DEPARTING_TO_ALZAHBI  = 1,
        FERRY_ARRIVING_FROM_SELBINA = 2,
        FERRY_DEPARTING_TO_SELBINA  = 3
    }
}

tpz.transport.interval =
{
    mhaura =
    {
        FROM_TO_ALZAHBI = 480,
        FROM_TO_SELBINA = 480
    }
}

tpz.transport.offset =
{
    mhaura =
    {
        FERRY_ARRIVING_FROM_ALZAHBI = 159,
        FERRY_DEPARTING_TO_ALZAHBI  = 239,
        FERRY_ARRIVING_FROM_SELBINA = 399,
        FERRY_DEPARTING_TO_SELBINA  = 479
    }
}

tpz.transport.pos =
{
    mhaura =
    {
        ARRIVING  = {{7.06, -1.36, 2.48}, {7.07, -1.36, 2.58}},
        DEPARTING = {{8.26, -1.36, 2.20}, {8.26, -1.36, 2.30}},
    }
}

-------------------------------------------------
-- public functions
-------------------------------------------------

tpz.transport.captainMessage = function(npc, triggerID, messages)
    local playersInZone = npc:getZone():getPlayers()
    for _, player in pairs(playersInZone) do
        player:showText(player, messages[triggerID])
    end
end

tpz.transport.dockMessage = function(npc, triggerID, messages, dock)
    npc:showText(npc, messages[triggerID])
    if (triggerID % 2) == 0 then
        npc:setLocalVar("[PATHING]DEPARTING", 2)
        npc:setPathPoint(1)
        npc:pathResume()
        --tpz.path.toPoint(npc, tpz.transport.pos[dock].ARRIVING, false)
    else
        npc:setLocalVar("[PATHING]DEPARTING", 1)
        npc:setPathPoint(1)
        npc:pathResume()
        --tpz.path.toPoint(npc, tpz.transport.pos[dock].DEPARTING, false)
    end
end
