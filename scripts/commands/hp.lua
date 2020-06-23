---------------------------------------------------------------------------------------------------
-- func: hp <amount> <player>
-- desc: Sets the GM or target players health.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "it"
}

function error(caller, player, msg)
    if (caller ~= player:getID()) then
        RemotePrintToPlayer(caller, msg)
        RemotePrintToPlayer(caller, "!hp <amount> {player}")
    else
        player:PrintToPlayer(msg)
        player:PrintToPlayer("!hp <amount> {player}")
    end
end

function print_message(caller, player, msg)
    if (caller ~= player:getID()) then
        RemotePrintToPlayer(caller, msg)
    else
        player:PrintToPlayer(msg)
    end
end

function onTrigger(caller, player, hp, target)
    -- validate amount
    if (hp == nil or tonumber(hp) == nil) then
        error(caller, player, "You must provide an amount.")
        return
    elseif (hp < 0) then
        error(caller, player, "Invalid amount.")
        return
    end

    -- validate target
    local targ
    local cursor_target = player:getCursorTarget()
    if (caller ~= player:getID()) then
        targ = player
    elseif target then
        targ = GetPlayerByName(target)
    elseif cursor_target then
        targ = cursor_target
    else
        targ = player
    end

    -- set hp
    if (targ:getHP() > 0) then
        targ:setHP(hp)
        if(targ:getID() ~= player:getID()) then
            print_message(caller, string.format("Set %s's HP to %i.", targ:getName(), targ:getHP()))
        end
    else
        print_message(caller, player, string.format("%s is currently dead.", targ:getName()))
    end
end
