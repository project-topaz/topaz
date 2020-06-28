---------------------------------------------------------------------------------------------------
-- func: getmobaction
-- desc: Prints mob's current action to the command user.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 5,
    parameters = "n"
}

function onTrigger(caller, entity, target)
    local targ = tpz.commands.getTargetMob(caller, entity, target)
    local usage = "!getmobaction {mobID}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a valid mobID.", usage)
        return
    end

    -- report mob action
    tpz.commands.print(caller, entity, string.format("%s %i current action ID is %i.", targ:getName(), targ:getID(), targ:getCurrentAction()))
end
