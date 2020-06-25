---------------------------------------------------------------------------------------------------
-- func: setplayerlevel
-- desc: Sets the target players level.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "ts"
}

function onTrigger(caller, player, arg1, arg2)
    local usage = "!setplayerlevel {player} <level>"
    local targ = tpz.commands.getTargetPC(caller, player, target)

    local level

    -- validate target
    if (arg2 ~= nil) then
        level = tonumber(arg2)
    elseif (arg1 ~= nil) then
        targ = player
        level = tonumber(arg1)
    end

    -- validate level
    if (level == nil or level < 1 or level > 99) then
        tpz.commands.error(caller, player, "Invalid level.  Must be between 1 and 99.", usage)
        return
    end

    -- set level
    targ:setLevel( level )
    if (targ:getID() ~= player:getID()) then
        tpz.commands.print(caller, player, string.format("Set %s's level to %i.", targ:getName(), level))
    end
end
