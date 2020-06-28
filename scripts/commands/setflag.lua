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

function onTrigger(caller, entity, flags, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!setflag <flags> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate flags
    if (flags == nil) then
        tpz.commands.error(caller, entity, "You must enter a number for the flags (hex values work).", usage)
        return
    end

    -- set flags
    targ:setFlag(flags)
end
