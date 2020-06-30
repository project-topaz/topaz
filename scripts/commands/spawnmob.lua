---------------------------------------------------------------------------------------------------
-- func: spawnmob
-- desc: Spawns a mob.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "iii"
}

function onTrigger(caller, player, mobId, despawntime, respawntime)
    local usage = "!spawnmob <mob ID> {despawntime} {respawntime}"

    -- validate mobId
    if (mobId == nil) then
        tpz.commands.error(caller, player, "You must provide a mob ID.", usage)
        return
    end
    local targ = GetMobByID(mobId)
    if (targ == nil) then
        tpz.commands.error(caller, player, "Invalid mob ID.", usage)
        return
    end

    -- validate despawntime
    if (despawntime ~= nil and despawntime < 0) then
        tpz.commands.error(caller, player, "Invalid despawn time.", usage)
        return
    end

    -- validate respawntime
    if (respawntime ~= nil and respawntime < 0) then
        tpz.commands.error(caller, player, "Invalid respawn time.", usage)
        return
    end

    SpawnMob(targ:getID(), despawntime, respawntime)
    tpz.commands.print(caller, player, string.format("Spawned %s %s.", targ:getName(), targ:getID()))
end
