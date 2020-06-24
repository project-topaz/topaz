tpz = tpz or {}
tpz.commands = tpz.commands or {}

tpz.commands.error = function(caller, target, msg, usage)
    if (caller ~= target:getID()) then
        RemotePrintToPlayer(caller, msg)
        RemotePrintToPlayer(caller, usage)
    else
        player:PrintToPlayer(msg)
        player:PrintToPlayer(usage)
    end
end

tpz.commands.print = function(caller, target, msg)
    if (caller ~= target:getID()) then
        RemotePrintToPlayer(caller, msg)
    else
        target:PrintToPlayer(msg)
    end
end

tpz.commands.getTarget = function(player, target)
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

    return targ
end