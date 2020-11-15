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

function onTrigger(caller, entity, tp, target)
    local targ = tpz.commands.getTarget(caller, entity, target)
    local usage = "!tp <amount> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate amount
    if (tp == nil or tonumber(tp) == nil) then
        tpz.commands.error(caller, entity, "You must provide an amount.", usage)
        return
    elseif (tp < 0) then
        tpz.commands.error(caller, entity, "Invalid amount.", usage)
        return
    end

    -- set tp
    targ:setTP(tp)
    local pet = targ:getPet()
    if (pet ~= nil) then
        pet:setTP(tp)
    end
    if(targ:getID() ~= caller) then
        tpz.commands.print(caller, entity, string.format("Set %s's TP to %i.", targ:getName(), targ:getTP()))
    end
end
