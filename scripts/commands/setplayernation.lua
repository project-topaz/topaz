---------------------------------------------------------------------------------------------------
-- func: setplayernation
-- desc: Sets the target players nation.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "ti"
}

function onTrigger(caller, player, target, nation)
    local usage = "!setplayernation {player} <nation>"
    local targ = tpz.commands.getTargetPC(player, target)

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
        tpz.commands.error(caller, player, "Invalid nation ID.", usage)
        tpz.commands.print(caller, player, "Nations: 0=San d'Oria 1=Bastok 2=Windurst")
        return
    end

    local nationByNum = {
        [0] = "San d'Oria",
        [1] = "Bastok",
        [2] = "Windurst"
    }

    -- set nation
    targ:setNation(nation)
    tpz.commands.print(caller, player, string.format("Set %s's home nation to %s.", targ:getName(), nationByNum[nation]))
end
