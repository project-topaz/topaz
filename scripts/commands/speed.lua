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

function onTrigger(caller, entity, speed)
    local usage = "!speed <0-255>"

    -- validate speed amount
    if (speed == nil or speed < 0 or speed > 255) then
        tpz.commands.error(caller, entity, "Invalid speed amount.", usage)
        return
    end

    -- set speed
    entity:speed(speed)

end
