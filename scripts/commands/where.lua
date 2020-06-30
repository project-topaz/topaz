---------------------------------------------------------------------------------------------------
-- func: where
-- desc: Tells the player about their current position.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(caller, player)
    player:showPosition()
end
