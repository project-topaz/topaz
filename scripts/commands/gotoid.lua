---------------------------------------------------------------------------------------------------
-- func: gotoid
-- desc: Go to given mob or npc ID
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "i"
}

function onTrigger(caller, entity, target)
    local usage = "!gotoid <mobId|npcId>"

    if (target == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a valid mobID/npcID.", usage)
        return
    end

    entity:goToEntity(target)
end
