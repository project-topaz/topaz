---------------------------------------------------------------------------------------------------
-- func: cs
-- desc: Starts the given event for the player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 5,
    parameters = "ssssssssss"
}

function onTrigger(caller, player, csid, op1, op2, op3, op4, op5, op6, op7, op8, texttable)
    local usage = "!cs <csID> {op1} {op2} {op3} {op4} {op5} {op6} {op7} {op8} {texttable}"

    -- validate csid
    if (csid == nil) then
        tpz.commands.error(caller, player, "You must enter a cutscene id.", usage)
        return
    end

    -- play cutscene
    if (op1 == nil) then
        player:startEvent(csid)
    else
        player:startEvent(csid, op1, op2, op3, op4, op5, op6, op7, op8, texttable)
    end
end
