---------------------------------------------------------------------------------------------------
-- func: posfix
-- desc: Resets a targets account session and warps them to Jeuno.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function onTrigger(caller, entity, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!posfix <player>"

    -- validate target
    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must supply the name of an offline player.", usage)
    else
        entity:resetPlayer(target)
        tpz.commands.print(caller, entity, string.format("Fixed %s's position.", target))
    end
end
