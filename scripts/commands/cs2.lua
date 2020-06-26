---------------------------------------------------------------------------------------------------
-- func: cs2
-- desc: Starts the given event for the player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "sssssiiiiiiii"
}

function onTrigger(caller, player, csid, string1, string2, string3, string4, op1, op2, op3, op4, op5, op6, op7, op8)
    local usage = "!cs2 <csID> {string1} {string2} {string3} {string4} {op1} {op2} {op3} {op4} {op5} {op6} {op7} {op8}"
    -- validate csid
    if (csid == nil) then
        tpz.commands.error(caller, player, "You must enter a cutscene id.", usage)
        return
    end

    -- play cs
    tpz.commands.print(caller, player, csid, string1, string2, string3, string4, op1, op2, op3, op4, op5, op6, op7, op8)
end
