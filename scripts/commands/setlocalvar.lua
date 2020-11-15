---------------------------------------------------------------------------------------------------
-- func: setlocalvar <varName> <player/mob/npc> <ID>
-- desc: set player npc or mob local variable and value.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "sisn"
}

function onTrigger(caller, entity, varName, varValue, target)
    local targ = tpz.commands.getTarget(caller, entity, target)
    local usage = "!setlocalvar <variable name> <value> {ID}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must enter a player id or mobID/npcID.", usage)
        return
    end

    if varName == nil then
        tpz.commands.error(caller, entity, "You must provide a variable name.", usage)
        return
    end

    if varValue == nil then
        tpz.commands.error(caller, entity, "No varaiable value given for target.", usage)
        return
    end

    targ:setLocalVar(varName, varValue)
    tpz.commands.print(caller, entity, string.format("%s's variable '%s' : %i", targ:getName(), varName, varValue))
end
