---------------------------------------------------------------------------------------------------
-- func: capskill
-- desc: Caps a specific skill.
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 2,
    parameters = "s"
}

function onTrigger(caller, player, skillId)
    local usage = "!capskill <skillID>"

    -- validate skillId
    if (skillId == nil) then
        tpz.commands.error(caller, player, "You must provide a skillID.", usage)
        return
    end
    skillId = tonumber(skillId) or tpz.skill[string.upper(skillId)]
    if (skillId == nil or skillId == 0) then
        tpz.commands.error(caller, player, "Invalid skillID.", usage)
        return
    end

    -- cap skill
    player:capSkill(skillId)
    tpz.commands.print(caller, player, string.format("Capped skillID %i.", skillId))
end
