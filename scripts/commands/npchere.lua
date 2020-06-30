---------------------------------------------------------------------------------------------------
-- func: npchere <npcId>
-- desc: Spawns an NPC and then moves it to the current position, if in same zone.
--       Errors will despawn the NPC unless "noDepop" was specified (any value works).
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!npchere {npcID} {noDepop}")
end

function onTrigger(caller, player, npcId, noDepop)
    local usage = "!npchere {npcID} {noDepop}"

    -- validate npc
    local targ
    if (npcId == nil) then
        targ = player:getCursorTarget()
        if (targ == nil or not targ:isNPC()) then
            tpz.commands.error(caller, player, "You must either provide an npcID or target an NPC.", usage)
            return
        end
    else
        targ = GetNPCByID(npcId)
        if (targ == nil) then
            tpz.commands.error(caller, player, "Invalid npcID.", usage)
            return
        end
    end

    if (player:getZoneID() == targ:getZoneID()) then
        targ:setPos(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID())
        targ:setStatus(tpz.status.NORMAL)
    else
        if (noDepop == nil or noDepop == 0) then
            targ:setStatus(tpz.status.DISAPPEAR)
            tpz.commands.print(caller, player, "Despawned the NPC because of an error.")
        end
        tpz.commands.print(caller, player, "NPC could not be moved to current pos - you are probably in the wrong zone.")
    end
end
