---------------------------------------------------------------------------------------------------
-- func: getmobaction
-- desc: Prints mob's current action to the command user.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 5,
    parameters = "i"
}

function onTrigger(caller, player, target)
    local targ = tpz.commands.getTargetMob(caller, player, target)

    -- report mob action
    tpz.commands.print(caller, player, string.format("%s %i current action ID is %i.", targ:getName(), targ:getID(), targ:getCurrentAction()))
end
