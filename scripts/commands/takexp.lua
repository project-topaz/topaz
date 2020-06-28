---------------------------------------------------------------------------------------------------
-- func: takexp <amount> <player>
-- desc: Removes experience points from the target player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "it"
}

function onTrigger(caller, entity, amount, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!takexp <amount> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate amount
    if (amount == nil or amount < 1) then
        tpz.commands.error(caller, entity, "Invalid amount.", usage)
        return
    end

    -- take xp
    targ:delExp(amount)
    tpz.commands.print(caller, entity, string.format("Removed %i exp from %s. They are now level %i.", amount, targ:getName(), targ:getMainLvl()))
end
