---------------------------------------------------------------------------------------------------
-- func: addallmaps
-- desc: Adds all maps to the given player.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 5,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
end

function onTrigger(player, target)
    print(tpz.mission.id.nation.NONE)
end
