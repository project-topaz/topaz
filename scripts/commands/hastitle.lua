---------------------------------------------------------------------------------------------------
-- func: hastitle
-- desc: Check if player already has a title.
---------------------------------------------------------------------------------------------------

require("scripts/globals/titles")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "st"
}

function onTrigger(caller, player, titleId, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!hastitle <title ID> {player}"

    -- validate titleId
    if (titleId == nil) then
        tpz.commands.error(caller, player, "You must supply a title ID.", usage)
        return
    end
    titleId = tonumber(titleId) or tpz.title[string.upper(titleId)]
    if (titleId == nil or titleId < 1) then
        tpz.commands.error(caller, player, "Invalid title ID.", usage)
        return
    end

    if (targ:hasTitle(titleId)) then
        tpz.commands.print(caller, player, string.format("%s has title %s.", targ:getName(), titleId))
    else
        tpz.commands.print(caller, player, string.format("%s does not have title %s.", targ:getName(), titleId))
    end
end
