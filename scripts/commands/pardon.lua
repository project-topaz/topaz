---------------------------------------------------------------------------------------------------
-- func: pardon
-- desc: Pardons a player from jail. (Mordion Gaol)
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "t"
}

function onTrigger(caller, player, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)

    if (targ:getCharVar('inJail') >= 1) then
        local message = string.format('%s is pardoning %s from jail.', player:getName(), targ:getName())
        printf(message)

        targ:setCharVar('inJail', 0)
        targ:warp()
    end
end
