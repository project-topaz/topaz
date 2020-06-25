---------------------------------------------------------------------------------------------------
-- func: getmod <modID>
-- desc: gets a mod by ID on the player or cursor target
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getmod <modID>")
end

function onTrigger(caller, player, id)
    local targ = tpz.commands.getTargetNonNPC(caller, player, nil)
    local usage = "!getmod <modID>"

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
        tpz.commands.error(caller, player, "Invalid modID.", usage)
        return
    end

    tpz.commands.print(caller, player, string.format("%s's Mod %i (%s) is %i", targ:getName(), modId, modName, targ:getMod(modId)))
end
