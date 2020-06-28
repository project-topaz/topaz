---------------------------------------------------------------------------------------------------
-- func: capskill
-- desc: Caps a specific skill.
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function onTrigger(caller, entity, skillId)
    local usage = "!capskill <skillID>"

    -- validate skillId
    if (skillId == nil) then
        tpz.commands.error(caller, entity, "You must provide a skillID.", usage)
        return
    end
    skillId = tonumber(skillId) or tpz.skill[string.upper(skillId)]
    if (skillId == nil or skillId == 0) then
        tpz.commands.error(caller, entity, "Invalid skillID.", usage)
        return
    end

    -- cap skill
    entity:capSkill(skillId)
    tpz.commands.print(caller, entity, string.format("Capped skillID %i.", skillId))
end
