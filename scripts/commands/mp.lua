---------------------------------------------------------------------------------------------------
-- func: mp <amount> <player>
-- desc: Sets the GM or target players mana.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 2,
    parameters = "it"
}

function onTrigger(caller, entity, mp, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!mp <amount> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate amount
    if (mp == nil or tonumber(mp) == nil) then
        tpz.commands.error(caller, entity, "You must provide an amount.", usage)
        return
    elseif (mp < 0) then
        tpz.commands.error(caller, entity, "Invalid amount.", usage)
        return
    end

    -- set mp
    if (targ:getHP() > 0) then
        targ:setMP(mp)
        if(targ:getID() ~= caller) then
            tpz.commands.print(caller, entity, string.format("Set %s's MP to %i.", targ:getName(), targ:getMP()))
        end
    else
        tpz.commands.print(caller, entity, string.format("%s is currently dead.", targ:getName()))
    end
end
