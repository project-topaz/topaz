---------------------------------------------------------------------------------------------------
-- func: addtitle
-- desc: Add and set player title.
---------------------------------------------------------------------------------------------------

require("scripts/globals/titles")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "st"
}

function onTrigger(caller, entity, titleId, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!addtitle <title ID> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate titleId
    if (titleId == nil) then
        tpz.commands.error(caller, entity, "You must supply a title ID.", usage)
        return
    end
    titleId = tonumber(titleId) or tpz.title[string.upper(titleId)]
    if (titleId == nil or titleId < 1) then
        tpz.commands.error(caller, entity, "Invalid title ID.", usage)
        return
    end

    -- add title
    targ:addTitle(titleId)
    tpz.commands.print(caller, entity, string.format("%s was given title %s.", targ:getName(), titleId))
end
