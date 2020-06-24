---------------------------------------------------------------------------------------------------
-- func: hp <amount> <player>
-- desc: Sets the GM or target players health.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "it"
}

function onTrigger(caller, player, hp, target)
    local usage = "!hp <amount> {player}"
    local targ = tpz.commands.getTarget(player, target)

    -- validate amount
    if (hp == nil or tonumber(hp) == nil) then
        tpz.commands.error(caller, player, "You must provide an amount.", usage)
        return
    elseif (hp < 0) then
        tpz.commands.error(caller, player, "Invalid amount.", usage)
        return
    end

    -- set hp
    if (targ:getHP() > 0) then
        targ:setHP(hp)
        if(targ:getID() ~= player:getID()) then
            tpz.commands.print(caller, player, string.format("Set %s's HP to %i.", targ:getName(), targ:getHP()))
        end
    else
        tpz.commands.print(caller, player, string.format("%s is currently dead.", targ:getName()))
    end
end
