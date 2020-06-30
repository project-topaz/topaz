---------------------------------------------------------------------------------------------------
-- func: addtitle
-- desc: Add and set player title.
---------------------------------------------------------------------------------------------------

require("scripts/globals/titles")
require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "st"
}

function onTrigger(caller, player, titleId, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!addtitle <title ID> {player}"

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

    -- add title
    targ:addTitle(titleId)
    tpz.commands.print(caller, player, string.format("%s was given title %s.", targ:getName(), titleId))
end
