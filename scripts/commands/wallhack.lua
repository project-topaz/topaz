---------------------------------------------------------------------------------------------------
-- func: wallhack <optional target>
-- desc: Allows the player to walk through walls.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "t"
}

function onTrigger(caller, entity, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!wallhack {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- toggle wallhack for target
    if (targ:checkNameFlags(0x00000200)) then
        targ:setFlag(0x00000200)
        tpz.commands.print(caller, entity, string.format("Toggled %s's wallhack flag OFF.", targ:getName()))
    else
        targ:setFlag(0x00000200)
        tpz.commands.print(caller, entity, string.format("Toggled %s's wallhack flag ON.", targ:getName()))
    end
end
