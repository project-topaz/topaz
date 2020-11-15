---------------------------------------------------------------------------------------------------
-- func: addlights <light type> <amount> <target player>
-- desc: Adds the amount of specified light to the player
---------------------------------------------------------------------------------------------------
-- lights: 1: pearl, 2: azure, 3: ruby, 4: amber, 5: gold, 6: silver, 7: ebon
---------------------------------------------------------------------------------------------------
require("scripts/globals/abyssea")

cmdprops =
{
    permission = 1,
    parameters = "sis"
}

local lightType =
{
    pearl  = 1,
    azure  = 2,
    ruby   = 3,
    amber  = 4,
    gold   = 5,
    silver = 6,
    ebon   = 7,
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!addlights <light type> <amount> {player}")
end

function onTrigger(player,light,amount,target)
    -- validate target
    local targ
    if (target == nil) then
        targ = player
    else
        targ = GetPlayerByName(target)
        if (targ == nil) then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    local selectedLight = tostring(light)
    
    if lightType[selectedLight] == nil  or selectedLight == nil then
        error(player, "Invalid light type.\nValid light types: pearl, azure, ruby, amber, gold, silver, ebon")
        return
    end

    local setLight = 0

    if lightType[selectedLight] ~= nil then
        setLight = lightType[selectedLight]
    end

    -- validate amount
    if (amount == nil or amount < 1) then
        error(player, "Invalid amount.")
        return
    end

    tpz.abyssea.AddPlayerLights(targ, setLight, amount)
    local newAmount = targ:getCharVar(light.."Light")
    player:PrintToPlayer(string.format("%s was given %i %s light, for a total of %i.",targ:getName(),amount,light,newAmount))
end