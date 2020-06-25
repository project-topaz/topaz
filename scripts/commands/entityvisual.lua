---------------------------------------------------------------------------------------------------
-- func: entityVisual
-- desc: push entityVisual packet to player
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 5,
    parameters = "s"
}

function onTrigger(caller, player, visualstring)
    local usage = "!entityvisual <animation string>"

    -- validate visualstring
    if (visualstring == nil) then
        tpz.commands.error(caller, player, "You must enter a valid animation string.", usage)
        return
    end

    -- push visual packet to player
    player:entityVisualPacket(visualstring)
end
