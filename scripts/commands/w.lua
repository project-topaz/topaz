---------------------------------------------------------------------------------------------------
-- func: w, world
-- desc: prints a message to the world
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!w <message>")
end

function onTrigger(player, msg)
    if msg == nil then
        error(player, "Cannot send an empty message because then it's not a message, it's just you fucking around.")
    else
        if player:getGMLevel() == 2 then
            player:PrintToArea(string.format("%s", msg), tpz.msg.channel.YELL, tpz.msg.area.SERVER, string.format("[GM]%s", player:getName()))
        elseif player:getGMLevel() == 3 then
            player:PrintToArea(string.format("%s", msg), tpz.msg.channel.YELL, tpz.msg.area.SERVER, string.format("[SGM]%s", player:getName()))
        elseif player:getGMLevel() == 4 then
            player:PrintToArea(string.format("%s", msg), tpz.msg.channel.YELL, tpz.msg.area.SERVER, string.format("[LGM]%s", player:getName()))
        elseif player:getGMLevel() == 5 then
            player:PrintToArea(string.format("%s", msg), tpz.msg.channel.YELL, tpz.msg.area.SERVER, string.format("[SO]%s", player:getName()))
        else
            player:PrintToArea(string.format("%s", msg), tpz.msg.channel.YELL, tpz.msg.area.SERVER, player:getName())
        end
    end
end