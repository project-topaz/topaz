---------------------------------------------------------------------------------------------------
-- func: setlocalvar <varName> <player/mob/npc> <ID>
-- desc: set player npc or mob local variable and value.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "siss"
}

function onTrigger(caller, player, arg1, arg2, arg3, arg4)
    local usage = "!setlocalvar <variable name> <value> {'player', 'mob', or 'npc'} {name or ID}"
    local targ = tpz.commands.getTarget(caller, player)

    local zone = player:getZone()
    local varName = arg1
    local varValue = arg2

    if varName == nil then
        tpz.commands.error(caller, player, "You must provide a variable name.", usage)
        return
    end

    if varValue == nil then
        tpz.commands.error(caller, player, "No varaiable value given for target.", usage)
        return
    end

    if arg3 == nil then
        targ = player:getCursorTarget()
    elseif arg4 ~= nil then
        local entity_type = string.upper(arg3)
        if (entity_type == 'NPC') or (entity_type == 'MOB') then
            arg4 = tonumber(arg4)
            if zone:getType() == tpz.zoneType.INSTANCED then
                local instance = player:getInstance()
                targ = instance:getEntity(bit.band(arg4, 0xFFF), tpz.objType[entity_type])
            elseif entity_type == 'NPC' then
                targ = GetNPCByID(arg4)
            else
                targ = GetMobByID(arg4)
            end
        elseif entity_type == 'PLAYER' then
            targ = GetPlayerByName(arg4)
        else
            tpz.commands.error(caller, player, "Invalid entity type.", usage)
            return
        end
    else
        tpz.commands.error(caller, player, "Need to specify a target.", usage)
        return
    end

    if targ == nil then
        tpz.commands.error(caller, player, "Invalid target.", usage)
        return
    end

    targ:setLocalVar(varName, varValue)
    tpz.commands.print(caller, player, string.format("%s's variable '%s' : %i", targ:getName(), varName, varValue))
end
