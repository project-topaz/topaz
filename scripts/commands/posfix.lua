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

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!posfix <player>")
end

function onTrigger(caller, player, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!posfix <player>"

    -- validate target
    if (targ == nil) then
        tpz.commands.error(caller, player, "You must supply the name of an offline player.", usage)
    else
        player:resetPlayer(target)
        tpz.commands.print(caller, player, string.format("Fixed %s's position.", target))
    end
end
