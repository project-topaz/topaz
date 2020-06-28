-----------------------------------------------------------------------
-- func: raise <power> <player>
-- desc: Sends raise menu to GM or target player.
-----------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 2,
    parameters = "st"
}

function onTrigger(caller, entity, power, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!raise {power} {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate power
    if (power == nil or power > 3) then
        power = 3
    elseif (power < 1) then
        power = 1
    end

    -- raise target
    if (targ:isDead()) then
        targ:sendRaise(power)
        if (targ:getID() ~= caller) then
            tpz.commands.print(caller, entity, string.format("Raise %i sent to %s.", power, targ:getName()))
        end
    else
        tpz.commands.print(caller, entity, string.format("%s is not dead.", targ:getName()))
    end
end
