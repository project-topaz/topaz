-----------------------------------
-- Command functions
-----------------------------------

tpz = tpz or {}
tpz.commands = tpz.commands or {}

-- handle printing error results locally or remotely
tpz.commands.error = function(caller, entity, msg, usage)
    if (caller ~= entity:getID()) then
        RemotePrintToPlayer(caller, msg)
        if (usage ~= nil) then
            RemotePrintToPlayer(caller, usage)
        end
    else
        entity:PrintToPlayer(msg)
        if (usage ~= nil) then
            entity:PrintToPlayer(usage)
        end
    end
end

-- handle printing command results locally or remotely
tpz.commands.print = function(caller, entity, msg)
    if (caller ~= entity:getID()) then
        RemotePrintToPlayer(caller, msg)
    else
        entity:PrintToPlayer(msg)
    end
end

-- get target from entity, target, or cursor
-- caller - identifies who ran the command
-- entity - could be PC, Mob, or NPC
-- target - id or name
tpz.commands.getTarget = function(caller, entity, target)
    -- validate target
    local targ
    local cursor_target
    if (entity:isPC()) then
        cursor_target = entity:getCursorTarget()
    end

    if (caller ~= entity:getID()) then
        targ = entity
    elseif target then
        local pctarg
        local mobtarg
        local npctarg

        if tonumber(target) then
            pctarg = GetPlayerByID(target)
            mobtarg = GetMobByID(target)
            npctarg = GetNPCByID(target)
        else
            pctarg = GetPlayerByName(target)
        end

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
        targ = entity
    end

    return targ
end

-- get target from entity, target, or cursor and filter for PC
tpz.commands.getTargetPC = function(caller, entity, target)
    local targ = tpz.commands.getTarget(caller, entity, target)
    if (targ and targ:isPC()) then
        return targ
    end

    return nil
end

-- get target from entity, target, or cursor and filter for Mob
tpz.commands.getTargetMob = function(caller, entity, target)
    local targ = tpz.commands.getTarget(caller, entity, target)
    if (targ and targ:isMob()) then
        return targ
    end

    return nil
end

-- get target from entity, target, or cursor and filter for NPC
tpz.commands.getTargetNPC = function(caller, entity, target)
    local targ = tpz.commands.getTarget(caller, entity, target)
    if (targ and targ:isNPC()) then
        return targ
    end

    return nil
end

-- get target from entity, target, or cursor and filter for PC or Mob
tpz.commands.getTargetNonNPC = function(caller, entity, target)
    local targ = tpz.commands.getTarget(caller, entity, target)
    if (targ and targ:isNPC() == false) then
        return targ
    end

    return nil
end

-- get target from entity, target, or cursor and filter for Mob or NPC
tpz.commands.getTargetNonPC = function(caller, entity, target)
    local targ = tpz.commands.getTarget(caller, entity, target)
    if (targ and targ:isPC() == false) then
        return targ
    end

    return nil
end
