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

function onTrigger(caller, player, mp, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!mp <amount> {player}"

    -- validate amount
    if (mp == nil or tonumber(mp) == nil) then
        tpz.commands.error(caller, player, "You must provide an amount.", usage)
        return
    elseif (mp < 0) then
        tpz.commands.error(caller, player, "Invalid amount.", usage)
        return
    end

    -- set mp
    if (targ:getHP() > 0) then
        targ:setMP(mp)
        if(targ:getID() ~= caller) then
            tpz.commands.print(caller, player, string.format("Set %s's MP to %i.", targ:getName(), targ:getMP()))
        end
    else
        tpz.commands.print(caller, player, string.format("%s is currently dead.", targ:getName()))
    end
end
