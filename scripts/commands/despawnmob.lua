---------------------------------------------------------------------------------------------------
-- func: despawnmob <mobid-optional>
-- desc: Despawns the given mob <t> or mobID)
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "n"
}

function onTrigger(caller, entity, target)
    local targ = tpz.commands.getTargetMob(caller, entity, target)
    local usage = "!despawnmob {mobID}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a valid mobID.", usage)
        return
    end

    -- despawn mob
    DespawnMob(targ:getID())
    tpz.commands.print(caller, entity, string.format("Despawned %s %i.", targ:getName(), targ:getID()))
end
