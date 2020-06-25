---------------------------------------------------------------------------------------------------
-- func: setmerits <amount> <player>
-- desc: Sets the target players merit count.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "it"
}

function onTrigger(caller, player, amount, target)
    local usage = "!setmerits <amount> {player}"
    local targ = tpz.commands.getTargetPC(caller, player, target)

    -- validate amount
    if (amount == nil or amount < 0) then
        tpz.commands.error(caller, player, "Invalid amount.", usage)
        return
    end

    -- set merits
    targ:setMerits(amount)
    tpz.commands.print(caller, player, string.format("%s now has %i merits.", targ:getName(), targ:getMeritCount()))
end
