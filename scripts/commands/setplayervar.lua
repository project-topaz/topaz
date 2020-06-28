---------------------------------------------------------------------------------------------------
-- func: setplayervar
-- desc: Sets a variable on the target player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "tsi"
}

function onTrigger(caller, entity, target, variable, value)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!setplayervar <player> <variable> <value>"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate var
    if (variable == nil) then
        tpz.commands.error(caller, entity, "You must provide a variable name.", usage)
        return
    end

    -- validate value
    if (value == nil) then
        tpz.commands.error(caller, entity, "You must provide a value.", usage)
        return
    end

    targ:setCharVar(variable, value)
    tpz.commands.print(caller, entity, string.format("Set %s's variable '%s' to %i.", targ:getName(), variable, value))
end
