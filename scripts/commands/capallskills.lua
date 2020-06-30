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

function onTrigger(caller, player)
    player:capAllSkills()
    tpz.commands.print(caller, player, 'All skills capped!')
end
