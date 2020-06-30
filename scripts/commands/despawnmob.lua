---------------------------------------------------------------------------------------------------
-- func: despawnmob <mobid-optional>
-- desc: Despawns the given mob <t> or mobID)
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "i"
}

function onTrigger(caller, player, mobId)
    local targ = tpz.commands.getTargetMob(caller, player, mobId)
    local usage = "!despawnmob {mobID}"

    -- despawn mob
    DespawnMob(targ:getID())
    tpz.commands.print(caller, player, string.format("Despawned %s %i.",targ:getName(),targ:getID()))
end
