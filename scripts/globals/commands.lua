tpz = tpz or {}
tpz.commands = tpz.commands or {}

tpz.commands.error = function(caller, target, msg, usage)
    if (caller ~= target:getID()) then
        RemotePrintToPlayer(caller, msg)
        RemotePrintToPlayer(caller, usage)
    else
        target:PrintToPlayer(msg)
        target:PrintToPlayer(usage)
    end
end

tpz.commands.print = function(caller, target, msg)
    if (caller ~= target:getID()) then
        RemotePrintToPlayer(caller, msg)
    else
        target:PrintToPlayer(msg)
    end
end

tpz.commands.getTarget = function(caller, player, target)
    -- validate target
    local targ
    local cursor_target = player:getCursorTarget()
    if (caller ~= player:getID()) then
        targ = player
    elseif target then
        local pctarg = GetPlayerByName(target)
        local mobtarg = GetMobByID(target)
        local npctarg = GetNPCByID(target)

        if pctarg then
            targ = pctarg
        elseif mobtarg then
            targ = mobtarg
        elseif npctarg then
            targ = npctarg
        else
            targ = nil
        end
    elseif cursor_target then
        targ = cursor_target
    else
        targ = player
    end

    return targ
end

tpz.commands.getTargetPC = function(caller, player, target)
    local targ = tpz.commands.getTarget(caller, player, target)
    if targ and targ:isPC() then
        return targ
    end

    return nil
end

tpz.commands.getTargetMob = function(caller, player, target)
    local targ = tpz.commands.getTarget(caller, player, target)
    if targ and targ:isMob() then
        return targ
    end

    return nil
end

tpz.commands.getTargetNPC = function(caller, player, target)
    local targ = tpz.commands.getTarget(caller, player, target)
    if targ and targ:isNPC() then
        return targ
    end

    return nil
end
