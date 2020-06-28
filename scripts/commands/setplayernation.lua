---------------------------------------------------------------------------------------------------
-- func: setplayernation
-- desc: Sets the target players nation.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "it"
}

function onTrigger(caller, entity, target, nation)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!setplayernation <nation> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    local nation

    -- validate target
    if (arg2 ~= nil) then
        nation = tonumber(arg2)
    elseif (arg1 ~= nil) then
        targ = player
        nation = tonumber(arg1)
    end

    -- validate nation
    if (nation == nil or nation < 0 or nation > 2) then
        tpz.commands.error(caller, entity, "Invalid nation ID.", usage)
        tpz.commands.print(caller, entity, "Nations: 0=San d'Oria 1=Bastok 2=Windurst")
        return
    end

    local nationByNum = {
        [0] = "San d'Oria",
        [1] = "Bastok",
        [2] = "Windurst"
    }

    -- set nation
    targ:setNation(nation)
    tpz.commands.print(caller, entity, string.format("Set %s's home nation to %s.", targ:getName(), nationByNum[nation]))
end
