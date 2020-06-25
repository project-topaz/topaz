---------------------------------------------------------------------------------------------------
-- func: setplayervar
-- desc: Sets a variable on the target player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "tsi"
}

function onTrigger(caller, player, target, variable, value)
    local usage = "!setplayervar <player> <variable> <value>"
    local targ = tpz.commands.getTargetPC(player, target)

    -- validate var
    if (variable == nil) then
        tpz.commands.error(caller, player, "You must provide a variable name.", usage)
        return
    end

    -- validate value
    if (value == nil) then
        tpz.commands.error(caller, player, "You must provide a value.", usage)
        return
    end

    targ:setCharVar(variable, value)
    tpz.commands.print(caller, player, string.format("Set %s's variable '%s' to %i.", targ:getName(), variable, value))
end
