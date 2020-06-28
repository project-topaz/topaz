---------------------------------------------------------------------------------------------------
-- func: setcraftRank <craft skill or ID> <craft rank> <target>
-- desc: sets target's RANK of specified craft skill
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "sst"
}

function onTrigger(caller, entity, craftName, tier, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!setcraftRank <craft skill or ID> <craft rank> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    if craftName == nil then
        tpz.commands.error(caller, entity, "You must specify a craft skill to set!", usage)
        return
    end

    local skillID = tonumber(craftName) or tpz.skill[string.upper(craftName)]
    if skillID == nil or skillID < 48 or skillID > 57 then
        tpz.commands.error(caller, entity, "You must specify a valid craft skill.", usage)
        return
    end

    if tier == nil then
        tpz.commands.error(caller, entity, "You must specify a rank to set the craft skill to.", usage)
        return
    end

    local craftRank = tonumber(tier) or tpz.craftRank[string.upper(tier)]
    if craftRank == nil then
        tpz.commands.error(caller, entity, "Invalid craft rank!", usage)
        return
    end

    targ:setSkillRank(skillID, craftRank)
    targ:PrintToPlayer(string.format("Your %s craft skill rank has been adjusted to: %s", craftName, craftRank))
    if targ ~= player then
        tpz.commands.print(caller, entity, string.format("%s's new skillID '%s' rank: %u", targ:getName(), craftName, targ:getSkillRank(skillID)))
    end
end
