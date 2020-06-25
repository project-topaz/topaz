---------------------------------------------------------------------------------------------------
-- func: tp <amount> <player>
-- desc: Sets a players tp. If they have a pet, also sets pet tp.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "it"
}

function onTrigger(caller, player, tp, target)
    local usage = "!tp <amount> {player}"
    local targ = tpz.commands.getTarget(caller, player, target)

    -- validate amount
    if (tp == nil or tonumber(tp) == nil) then
        tpz.commands.error(caller, player, "You must provide an amount.", usage)
        return
    elseif (tp < 0) then
        tpz.commands.error(caller, player, "Invalid amount.", usage)
        return
    end

    -- set tp
    targ:setTP(tp)
    local pet = targ:getPet()
    if (pet ~= nil) then
        pet:setTP(tp)
    end
    if(targ:getID() ~= player:getID()) then
        tpz.commands.print(caller, player, string.format("Set %s's TP to %i.", targ:getName(), targ:getTP()))
    end
end
