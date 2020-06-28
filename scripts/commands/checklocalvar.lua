---------------------------------------------------------------------------------------------------
-- func: checklocalvar <varName> {name/ID}
-- desc: checks player or npc local variable and returns result value.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 5,
    parameters = "ssn"
}

function onTrigger(caller, entity, varName, target)
    local targ = tpz.commands.getTarget(caller, entity, target)
    local usage = "!checklocalvar <variable name> {ID}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must enter a player id or mobID/npcID.", usage)
        return
    end

    if varName == nil then
        tpz.commands.error(caller, entity, "You must provide a variable name.", usage)
        return
    end

    tpz.commands.print(caller, entity, string.format("%s's variable '%s' : %i", targ:getName(), varName, targ:getLocalVar(varName)))
end
