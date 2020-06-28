---------------------------------------------------------------------------------------------------
-- func: givegil <amount> <player>
-- desc: Gives the specified amount of gil to GM or target player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "it"
}

function onTrigger(caller, entity, amount, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!givegil <amount> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate amount
    if (amount == nil or amount < 1) then
        tpz.commands.error(caller, entity, "Invalid amount of gil.", usage)
        return
    end

    -- give gil to target
    targ:addGil(amount)
    tpz.commands.print(caller, entity, string.format("Gave %i gil to %s.  They now have %i gil.", amount, targ:getName(), targ:getGil()))
end
