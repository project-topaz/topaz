---------------------------------------------------------------------------------------------------
-- func: givexp <amount> <player>
-- desc: Gives the GM or target player experience points.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "it"
}

function onTrigger(caller, player, amount, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!givexp <amount> {player}"

    -- validate amount
    if (amount == nil or amount < 1) then
        tpz.commands.error(caller, player, "Invalid amount.", usage)
        return
    end

    -- give XP to target
    targ:addExp(amount)
    tpz.commands.print(caller, player, string.format( "Gave %i exp to %s. They are now level %i.", amount, targ:getName(), targ:getMainLvl()))
end
