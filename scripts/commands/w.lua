---------------------------------------------------------------------------------------------------
-- func: w, world
-- desc: prints a message to the world
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 0,
    parameters = "s"
}

function onTrigger(caller, player, msg)
    local usage = "!w <message>"

    if (msg == nil) then
        tpz.commands.error(caller, player, "Cannot send an empty message because then it's not a message, it's just you fucking around.", usage)
    else
        if (player:getGMLevel() == 2) then
            tpz.commands.print(caller, player, string.format("%s", msg), tpz.msg.channel.YELL, tpz.msg.area.SERVER, string.format("[GM]%s", player:getName()))
        elseif (player:getGMLevel() == 3) then
            tpz.commands.print(caller, player, string.format("%s", msg), tpz.msg.channel.YELL, tpz.msg.area.SERVER, string.format("[SGM]%s", player:getName()))
        elseif (player:getGMLevel() == 4) then
            tpz.commands.print(caller, player, string.format("%s", msg), tpz.msg.channel.YELL, tpz.msg.area.SERVER, string.format("[LGM]%s", player:getName()))
        elseif (player:getGMLevel() == 5) then
            tpz.commands.print(caller, player, string.format("%s", msg), tpz.msg.channel.YELL, tpz.msg.area.SERVER, string.format("[DEV]%s", player:getName()))
        elseif (player:getGMLevel() >= 6) then
            tpz.commands.print(caller, player, string.format("%s", msg), tpz.msg.channel.YELL, tpz.msg.area.SERVER, string.format("[SO]%s", player:getName()))
        else
            tpz.commands.print(caller, player, string.format("%s", msg), tpz.msg.channel.YELL, tpz.msg.area.SERVER, player:getName())
        end
    end
end