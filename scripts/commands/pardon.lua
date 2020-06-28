---------------------------------------------------------------------------------------------------
-- func: pardon
-- desc: Pardons a player from jail. (Mordion Gaol)
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 2,
    parameters = "t"
}

function onTrigger(caller, entity, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage "!pardon {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    if (targ:getCharVar('inJail') >= 1) then
        local message = string.format('%s is pardoning %s from jail.', player:getName(), targ:getName())
        printf(message)

        targ:setCharVar('inJail', 0)
        targ:warp()
    end
end
