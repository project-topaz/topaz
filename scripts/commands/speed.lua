---------------------------------------------------------------------------------------------------
-- func: speed
-- desc: Sets the players movement speed.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!speed <0-255>")
end

function onTrigger(caller, player, speed)
    local usage = "!speed <0-255>"

    -- validate speed amount
    if (speed == nil or speed < 0 or speed > 255) then
        tpz.commands.error(caller, player, "Invalid speed amount.", usage)
        return
    end

    -- set speed
    player:speed(speed)

end
