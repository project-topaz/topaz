---------------------------------------------------------------------------------------------------
-- func: inject
-- desc: Injects the given packet data.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function onTrigger(caller, entity, packet)
    local usage = "!inject <packet>"
    -- validate packet
    if (packet == nil) then
        tpz.commands.error(caller, entity, "You must enter a packet file name.", usage)
        return
    end

    -- inject packet
    entity:injectPacket(packet)
end
