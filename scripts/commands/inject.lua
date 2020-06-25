---------------------------------------------------------------------------------------------------
-- func: inject
-- desc: Injects the given packet data.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 5,
    parameters = "s"
}

function onTrigger(caller, player, packet)
    local usage = "!inject <packet>"
    -- validate packet
    if (packet == nil) then
        tpz.commands.error(caller, player, "You must enter a packet file name.", usage)
        return
    end

    -- inject packet
    player:injectPacket(packet)
end
