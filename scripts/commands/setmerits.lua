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

function onTrigger(caller, entity, amount, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!setmerits <amount> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate amount
    if (amount == nil or amount < 0) then
        tpz.commands.error(caller, entity, "Invalid amount.", usage)
        return
    end

    -- set merits
    targ:setMerits(amount)
    tpz.commands.print(caller, entity, string.format("%s now has %i merits.", targ:getName(), targ:getMeritCount()))
end
