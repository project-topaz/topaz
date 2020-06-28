---------------------------------------------------------------------------------------------------
-- func: checkvar <varName> <varType>
-- desc: checks player or server variable and returns result value.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "ss"
}

function onTrigger(caller, entity, varName, target)
    local targ
    if (string.upper(target) == 'SERVER') then
        targ = "server"
    else
        targ = target
    end
    local usage = "!checkvar <variable name> {'server', or player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name or provide SERVER.", usage)
        return
    end

    -- validate varName
    if (varName == nil) then
        tpz.commands.error(caller, entity, "You must provide a variable name.", usage)
        return
    end

    -- show variable
    if (targ == "server") then
        tpz.commands.print(caller, entity, string.format("Server variable '%s' : %u ", varName, GetServerVariable(varName)))
    else
        local found, value = GetCharVariable(varName, targ)
        if (found == true) then
            tpz.commands.print(caller, entity, string.format("%s's variable '%s' : %u", targ, varName, value))
        else
            tpz.commands.error(caller, entity, string.format("variable '%s' not found for player: %s", varName, targ), usage)
        end
    end
end
