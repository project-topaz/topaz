---------------------------------------------------------------------------------------------------
-- func: takexp <amount> <player>
-- desc: Removes experience points from the target player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "it"
}

function onTrigger(caller, player, amount, target)
    local usage = "!takexp <amount> {player}"
    local targ = tpz.commands.getTargetPC(caller, player, target)

    -- validate amount
    if (amount == nil or amount < 1) then
        tpz.commands.error(caller, player, "Invalid amount.", usage)
        return
    end

    -- take xp
    targ:delExp(amount)
    tpz.commands.print(caller, player, string.format("Removed %i exp from %s. They are now level %i.", amount, targ:getName(), targ:getMainLvl()))
end
