---------------------------------------------------------------------------------------------------
-- func: cnation <target> <campaign allegiance>
-- desc: check or alter target characters campaign allegiance
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "ts"
}

function onTrigger(caller, entity, target, nation)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!cnation <player> <campaign allegiance>"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- nation xref tables
    local nationNameToNum = {
        ["NONE"]     =  0,
        ["SANDORIA"] =  1,
        ["BASTOK"]   =  2,
        ["WINDURST"] =  3
    }
    local nationNumToName ={}
    for k,v in pairs(nationNameToNum) do
        nationNumToName[v]=k
    end

    -- show or set allegiance
    if (nation == nil) then
        tpz.commands.print(caller, entity, string.format("%s's current campaign allegiance: %s", targ:getName(), nationNumToName[targ:getCampaignAllegiance()]))
    else
        nation = tonumber(nation) or nationNameToNum[string.upper(nation)]
        if (nation == nil or nation < 0 or nation > 3) then
            tpz.commands.error(caller, entity, "Invalid campaign allegiange. Valid choices are SANDORIA (1), BASTOK (2), or WINDURST (3).", usage)
            return
        end
        tpz.commands.print(caller, entity, string.format("%s's old campaign allegiance: %s", targ:getName(), nationNumToName[targ:getCampaignAllegiance()]))
        targ:setCampaignAllegiance(nation)
        tpz.commands.print(caller, entity, string.format("%s's new campaign allegiance: %s", targ:getName(), nationNumToName[targ:getCampaignAllegiance()]))
    end
end
