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
            player:PrintToArea(string.format("[World] [GM]%s: %s", player:getName(), msg), tpz.msg.channel.NS_PARTY, tpz.msg.area.SERVER, "No One")
        elseif player:getGMLevel() == 3 then
            player:PrintToArea(string.format("[World] [SGM]%s: %s", player:getName(), msg), tpz.msg.channel.NS_PARTY, tpz.msg.area.SERVER, "No One")
        elseif player:getGMLevel() == 4 then
            player:PrintToArea(string.format("[World] [LGM]%s: %s", player:getName(), msg), tpz.msg.channel.NS_PARTY, tpz.msg.area.SERVER, "No One")
        elseif player:getGMLevel() == 5 then
            player:PrintToArea(string.format("[World] [SO]%s: %s", player:getName(), msg), tpz.msg.channel.NS_PARTY, tpz.msg.area.SERVER, "No One")
        else
            player:PrintToArea(string.format("[World] %s: %s", player:getName(), msg), tpz.msg.channel.NS_PARTY, tpz.msg.area.SERVER, "No One")
        end
    end
end