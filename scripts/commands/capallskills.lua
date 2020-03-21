---------------------------------------------------------------------------------------------------
-- func: capallskills
-- desc: Caps all the players skills.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = ""
}

function onTrigger(player)
    player:capAllSkills()
    player:PrintToPlayer( 'All skills capped!' )
end
