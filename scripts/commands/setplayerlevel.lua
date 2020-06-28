---------------------------------------------------------------------------------------------------
-- func: setplayerlevel
-- desc: Sets the target players level.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "st"
}

function onTrigger(caller, entity, level, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!setplayerlevel <level> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate level
    if (level == nil or level < 1 or level > 99) then
        tpz.commands.error(caller, entity, "Invalid level.  Must be between 1 and 99.", usage)
        return
    end

    -- set level
    targ:setLevel(level)
    if (targ:getID() ~= caller) then
        tpz.commands.print(caller, entity, string.format("Set %s's level to %i.", targ:getName(), level))
    end
end
