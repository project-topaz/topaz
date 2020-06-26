---------------------------------------------------------------------------------------------------
-- func: costume
-- desc: Sets the players current costume.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function onTrigger(caller, player, costumeId)
    local usage = "!costume <costumeID>"
    -- validate costumeId
    if (costumeId == nil or costumeId < 0) then
        tpz.commands.error(caller, player, "Invalid costumeID.", usage)
        return
    end

    -- put on costume
    player:costume(costumeId)
end
