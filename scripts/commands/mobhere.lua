---------------------------------------------------------------------------------------------------
-- func: mobhere <mobId>
-- desc: Spawns a MOB and then moves it to the current position, if in same zone.
--       Errors will despawn the MOB unless "noDepop" was specified (any value works).
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "is"
}

function onTrigger(caller, entity, mobId, noDepop)
    local usage = "!mobhere {mobID} {noDepop}"

    -- validate mobId
    local targ
    if (mobId == nil) then
        targ = entity:getCursorTarget()
        if (targ == nil or not targ:isMob()) then
            tpz.commands.error(caller, entity, "You must either provide a mobID or target a mob.", usage)
            return
        end
    else
        targ = GetMobByID(mobId)
        if (targ == nil) then
            tpz.commands.error(caller, entity, "Invalid mobID.", usage)
            return
        end
    end
    mobId = targ:getID()

    -- attempt to bring mob here
    SpawnMob(mobId)
    if (entity:getZoneID() == targ:getZoneID()) then
        targ:setPos(entity:getXPos(), entity:getYPos(), entity:getZPos(), entity:getRotPos(), entity:getZoneID())
    else
        if (noDepop == nil or noDepop == 0) then
            DespawnMob(mobId)
            tpz.commands.print(caller, entity, "Despawned the mob because of an error.")
        end
        tpz.commands.print(caller, entity, "Mob could not be moved to current pos - you are probably in the wrong zone.")
    end
end
