---------------------------------------------------------------------------------------------------
-- func: setflag <flags> <target>
-- desc: set arbitrary flags for testing
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "st"
}

function onTrigger(caller, player, flags, target)
    local usage = "!setflag <flags> {player}"
    local targ = tpz.commands.getTargetPC(caller, player)

    -- validate flags
    if (flags == nil) then
        tpz.commands.error(player, "You must enter a number for the flags (hex values work).", usage)
        return
    end

    -- set flags
    targ:setFlag(flags)
end
