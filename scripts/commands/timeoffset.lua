---------------------------------------------------------------------------------------------------
-- func: timeoffset
-- desc: Sets the custom time offset of the CVanaTime instance.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 5
    parameters = "i"
}

function onTrigger(caller, player, offset)
    local usage = "!timeoffset <offset>"

    -- validate offset
    if (offset == nil) then
        tpz.commands.error(caller, player, "Invalid offset.", usage)
        return
    end

    -- time offset
    local result = SetVanadielTimeOffset(offset)
    if (result == nil) then
        tpz.commands.error(player, "Time offset was not successful.")
        return
    end
end
