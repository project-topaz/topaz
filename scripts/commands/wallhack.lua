---------------------------------------------------------------------------------------------------
-- func: wallhack <optional target>
-- desc: Allows the player to walk through walls.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "t"
}

function onTrigger(caller, player, target)
    local targ = tpz.commands.getTarget(player, target)

    -- toggle wallhack for target
    if (targ:checkNameFlags(0x00000200)) then
        targ:setFlag(0x00000200)
        tpz.commands.print(caller, player, string.format("Toggled %s's wallhack flag OFF.", targ:getName()))
    else
        targ:setFlag(0x00000200)
        tpz.commands.print(caller, player, string.format("Toggled %s's wallhack flag ON.", targ:getName()))
    end
end
