-----------------------------------------------------------------------
-- func: raise <power> <player>
-- desc: Sends raise menu to GM or target player.
-----------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "st"
}

function onTrigger(caller, player, power, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!raise {power} {player}"

    -- validate power
    if (power == nil or power > 3) then
        power = 3
    elseif (power < 1) then
        power = 1
    end

    -- raise target
    if (targ:isDead()) then
        targ:sendRaise(power)
        if (targ:getID() ~= player:getID()) then
            tpz.commands.print(caller, player, string.format("Raise %i sent to %s.", power, targ:getName()))
        end
    else
        tpz.commands.print(caller, player, string.format("%s is not dead.", targ:getName()))
    end
end
