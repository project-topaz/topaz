---------------------------------------------------------------------------------------------------
-- func: timeoffset
-- desc: Sets the custom time offset of the CVanaTime instance.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function onTrigger(caller, entity, offset)
    local usage = "!timeoffset <offset>"

    -- validate offset
    if (offset == nil) then
        tpz.commands.error(caller, entity, "Invalid offset.", usage)
        return
    end

    -- time offset
    local result = SetVanadielTimeOffset(offset)
    if (result == nil) then
        tpz.commands.error(caller, entity, "Time offset was not successful.", usage)
        return
    end
end
