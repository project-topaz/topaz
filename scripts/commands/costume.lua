---------------------------------------------------------------------------------------------------
-- func: costume
-- desc: Sets the players current costume.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 2,
    parameters = "i"
}

function onTrigger(caller, entity, costumeId)
    local usage = "!costume <costumeID>"
    -- validate costumeId
    if (costumeId == nil or costumeId < 0) then
        tpz.commands.error(caller, entity, "Invalid costumeID.", usage)
        return
    end

    -- put on costume
    entity:costume(costumeId)
end
