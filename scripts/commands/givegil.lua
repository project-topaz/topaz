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

function onTrigger(caller, player, amount, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!givegil <amount> {player}"

    -- validate amount
    if (amount == nil or amount < 1) then
        tpz.commands.error(caller, player, "Invalid amount of gil.", usage)
        return
    end

    -- give gil to target
    targ:addGil(amount)
    tpz.commands.print(caller, player, string.format("Gave %i gil to %s.  They now have %i gil.", amount, targ:getName(), targ:getGil()))
end
