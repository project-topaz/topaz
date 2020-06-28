---------------------------------------------------------------------------------------------------
-- func: capallskills
-- desc: Caps all the players skills.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 2,
    parameters = ""
}

function onTrigger(caller, entity)
    entity:capAllSkills()
    tpz.commands.print(caller, entity, 'All skills capped!')
end
