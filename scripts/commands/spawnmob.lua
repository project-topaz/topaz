---------------------------------------------------------------------------------------------------
-- func: spawnmob
-- desc: Spawns a mob.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "nii"
}

function onTrigger(caller, entity, mobId, despawntime, respawntime)
    local usage = "!spawnmob <mob ID> {despawntime} {respawntime}"

    -- validate mobId
    if (mobId == nil) then
        tpz.commands.error(caller, entity, "You must provide a mob ID.", usage)
        return
    end

    local targ = tpz.commands.getTargetMob(caller, entity, mobId)
    if (targ == nil) then
        tpz.commands.error(caller, entity, "Invalid mob ID.", usage)
        return
    end

    -- validate despawntime
    if (despawntime ~= nil and despawntime < 0) then
        tpz.commands.error(caller, entity, "Invalid despawn time.", usage)
        return
    end

    -- validate respawntime
    if (respawntime ~= nil and respawntime < 0) then
        tpz.commands.error(caller, entity, "Invalid respawn time.", usage)
        return
    end

    SpawnMob(targ:getID(), despawntime, respawntime)
    tpz.commands.print(caller, entity, string.format("Spawned %s %s.", targ:getName(), targ:getID()))
end
