---------------------------------------------------------------------------------------------------
-- func: hp <amount> <player>
-- desc: Sets the GM or target players health.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "it"
}

function onTrigger(caller, entity, hp, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!hp <amount> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate amount
    if (hp == nil or tonumber(hp) == nil) then
        tpz.commands.error(caller, entity, "You must provide an amount.", usage)
        return
    elseif (hp < 0) then
        tpz.commands.error(caller, entity, "Invalid amount.", usage)
        return
    end

    -- set hp
    if (targ:getHP() > 0) then
        targ:setHP(hp)
        if(targ:getID() ~= caller) then
            tpz.commands.print(caller, entity, string.format("Set %s's HP to %i.", targ:getName(), targ:getHP()))
        end
    else
        tpz.commands.print(caller, entity, string.format("%s is currently dead.", targ:getName()))
    end
end
