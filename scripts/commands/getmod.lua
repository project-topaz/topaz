---------------------------------------------------------------------------------------------------
-- func: getmod <modID>
-- desc: gets a mod by ID on the player or cursor target
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 5,
    parameters = "s"
}

function onTrigger(caller, entity, id)
    local targ = tpz.commands.getTargetNonNPC(caller, entity, nil)
    local usage = "!getmod <modID>"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name, mobID.", usage)
        return
    end

    -- invert tpz.mod table
    local modNameByNum = {}
    for k,v in pairs(tpz.mod) do
        modNameByNum[v]=k
    end

    -- validate modID
    id = string.upper(id)
    local modId = tonumber(id)
    local modName = nil

    if modId ~= nil then
        if modNameByNum[modId] ~= nil then
            modName = modNameByNum[modId]
        end
    elseif tpz.mod[id] ~= nil then
        modId = tpz.mod[id]
        modName = id
    end
    if modName == nil or modId == nil then
        tpz.commands.error(caller, entity, "Invalid modID.", usage)
        return
    end

    tpz.commands.print(caller, entity, string.format("%s's Mod %i (%s) is %i", targ:getName(), modId, modName, targ:getMod(modId)))
end
