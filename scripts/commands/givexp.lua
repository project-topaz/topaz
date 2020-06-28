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

function onTrigger(caller, entity, amount, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!givexp <amount> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate amount
    if (amount == nil or amount < 1) then
        tpz.commands.error(caller, entity, "Invalid amount.", usage)
        return
    end

    -- give XP to target
    targ:addExp(amount)
    tpz.commands.print(caller, entity, string.format( "Gave %i exp to %s. They are now level %i.", amount, targ:getName(), targ:getMainLvl()))
end
