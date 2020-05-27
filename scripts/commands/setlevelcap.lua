---------------------------------------------------------------------------------------------------
-- func: setlevelcap
-- desc: Sets a player's level cap (does not complete the quest)
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 4,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setlevelcap <level cap> <player>")
end

function onTrigger(player, levelCap, target)
    -- validate cap
    if   levelCap ~= 50
      and levelCap ~= 55
      and levelCap ~= 60
      and levelCap ~= 65
      and levelCap ~= 70
      and levelCap ~= 75
      and levelCap ~= 80 then
        error(player, "You must supply a valid level cap.")
        return
    end

    -- validate target
    local targ
    targ = GetPlayerByName(target)
    if (targ == nil) then
        error(player, string.format("Player named '%s' not found!", target))
        return
    end

    -- set cap
    targ:levelCap(75);
    player:PrintToPlayer( string.format("%s's level cap was set to %i", targ:getName(), (levelCap)))
    targ:PrintToPlayer("Your level cap was set to " ..levelCap..".", 29)
end
